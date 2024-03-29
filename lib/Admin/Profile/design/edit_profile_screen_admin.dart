import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/Home/design/home_screen_admin.dart';
import 'package:restaurant_booking_management/Login/design/reset_password.dart';
import 'package:restaurant_booking_management/Signup/provider/signup_provider.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_font.dart';
import '../../../utils/mixin_textformfield.dart';
import '../../../utils/mixin_toast.dart';

class EditProfileScreenAdmin extends StatefulWidget {
  const EditProfileScreenAdmin({Key? key}) : super(key: key);

  @override
  State<EditProfileScreenAdmin> createState() => _EditProfileScreenAdminState();
}

class _EditProfileScreenAdminState extends State<EditProfileScreenAdmin> {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appColor.withOpacity(0.9),
          centerTitle: true,
          title: const Text('Edit Profile',style: TextStyle(fontFamily: AppFont.semiBold),),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser?.email).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
              if (snapshot.hasError) {
                debugPrint('Something went wrong');
                return const Text("Something went wrong");
              }
              else if (!snapshot.hasData || !snapshot.data!.exists) {
                debugPrint('Document does not exist');
                return const Center(child: CircularProgressIndicator());
              } else if(snapshot.requireData.exists){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(top:00),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          // const SizedBox(height: 5),
                          TextFieldMixin().textFieldWidget(
                            textStyle: const TextStyle(fontFamily: AppFont.regular),
                            labelText: 'Full Name',
                            labelStyle: const TextStyle(color: AppColor.appColor),
                            controller: fullNameController..text = data['fullName'],
                            maxLines: 5
                          ),
                          const SizedBox(height: 10),
                          TextFieldMixin().textFieldWidget(
                            textStyle: const TextStyle(fontFamily: AppFont.regular),
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: AppColor.appColor),
                            controller: emailController..text = data['email'],
                            readOnly: true,
                              maxLines: 5
                          ),
                          const SizedBox(height: 10),
                          TextFieldMixin().textFieldWidget(
                            textStyle: const TextStyle(fontFamily: AppFont.regular),
                            labelText: 'Phone',
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)],
                            labelStyle: const TextStyle(color: AppColor.appColor),
                            controller: phoneController..text = data['phone'],
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 35,),
                          GestureDetector(
                              onTap: () async {
                                if(fullNameController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty || phoneController.text.trim().length != 10){
                                  showToast(
                                      toastMessage: phoneController.text.trim().length != 10?"Please fill 10 digits phone number":"Please fill all required details"
                                  );
                                }else{
                                  FocusScope.of(context).unfocus();
                                  var token = (await FirebaseMessaging.instance.getToken())!;
                                  if (!mounted) return;
                                  Provider.of<SignupProvider>(context,listen: false).
                                  insertDataUser(fullNameController.text, emailController.text.toLowerCase(), phoneController.text, "Restaurant Owner",token).then((value) async {
                                    if(value == true){
                                      Navigator.pop(context);
                                      await Future.delayed(const Duration(milliseconds: 500));
                                      showToast(
                                          toastMessage: "Updated Successfully"
                                      );
                                    }else{
                                      showToast(
                                          toastMessage: "Update Failure"
                                      );
                                    }
                                  });
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenAdmin()));
                                }
                                },
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: AppColor.lightBlue
                                    gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: [Colors.green.shade400,Colors.green.shade600,Colors.green.shade700]
                                    )
                                ),
                                child: const Center(
                                    child: Text("Update",
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontFamily: AppFont.semiBold,
                                          fontSize: 20
                                      ),
                                    )
                                ),
                              )
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword(check: "Edit")));
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              // color: Colors.amber,
                              alignment: Alignment.centerLeft,
                                child: Row(
                                  children: const [
                                    Text("Change Password",style: TextStyle(color: AppColor.black,fontSize: 20,fontFamily: AppFont.bold)),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios_outlined,color: AppColor.black,)
                                  ],
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
              else if (snapshot.connectionState == ConnectionState.done) {
                return const Center(child: CircularProgressIndicator(),);
              }
              else{
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ),
      ),
    );
  }
}
