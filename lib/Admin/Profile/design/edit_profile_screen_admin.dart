import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/Home/design/home_screen_admin.dart';
import 'package:restaurant_booking_management/Login/design/reset_password.dart';
import 'package:restaurant_booking_management/Signup/provider/signup_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          title: const Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser?.email).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
              if (snapshot.hasError) {
                print('Something went wrong');
                return const Text("Something went wrong");
              }
              else if (!snapshot.hasData || !snapshot.data!.exists) {
                print('Document does not exist');
                return const Center(child: CircularProgressIndicator());
              } else if(snapshot.requireData.exists){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(top:5),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          // const SizedBox(height: 5),
                          TextFieldMixin().textFieldWidget(
                            labelText: 'FullName',
                            controller: fullNameController..text = data['fullName'],
                          ),
                          const SizedBox(height: 10),
                          TextFieldMixin().textFieldWidget(
                            labelText: 'Email',
                            controller: emailController..text = data['email'],
                            readOnly: true,
                          ),
                          const SizedBox(height: 10),
                          TextFieldMixin().textFieldWidget(
                            labelText: 'Phone',
                            controller: phoneController..text = data['phone'],
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 35,),
                          GestureDetector(
                              onTap: () async {
                                if(fullNameController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty){
                                  showToast(
                                      toastMessage: "Please fill all required details"
                                  );
                                }else{
                                  Provider.of<SignupProvider>(context,listen: false).
                                  insertDataUser(fullNameController.text, emailController.text, phoneController.text, "Restaurant Owner");
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreenAdmin()));
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