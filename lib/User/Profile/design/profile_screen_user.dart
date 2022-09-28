import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_booking_management/User/Profile/design/edit_profile_screen_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Admin/Home/design/home_screen_admin.dart';
import '../../../Login/design/login_screen.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_font.dart';
import '../../Home/design/home_screen_user.dart';

class ProfileScreenUser extends StatefulWidget {
  const ProfileScreenUser({Key? key}) : super(key: key);

  @override
  State<ProfileScreenUser> createState() => _ProfileScreenUserState();
}

class _ProfileScreenUserState extends State<ProfileScreenUser> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/2.5,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  );
                } else if(snapshot.requireData.exists){
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height/3,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60)),
                                  // color: AppColor.appColor.withOpacity(0.2),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      colors: [Colors.green.shade400,Colors.green.shade600,Colors.green.shade800]
                                  )
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 0,right: 0,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    ClipOval(
                                      child: Container(
                                          color: AppColor.white,
                                          height: 80,width: 80,
                                          child: Center(
                                            child: Text('${data['fullName']?.substring(0,1).toUpperCase()}',
                                              style: const TextStyle(color: AppColor.appColor,fontSize: 40,fontFamily: AppFont.regular),),
                                          )
                                      ),
                                    ),
                                    /*ClipOval(
                                        child:
                                        data['imageUrl'] == "" ? Container(
                                          color: AppColor.appColor,
                                          height: 80,width: 80,child: Center(
                                          child: Text('${data['employeeName']?.substring(0,1).toUpperCase()}',
                                              style: const TextStyle(color: AppColor.appBlackColor,fontSize: 30)),
                                        ),) :
                                        Image.network(
                                            '${data['imageUrl']}',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.fill)
                                    ),*/
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 00, 10, 00),
                                      child: Text(data['fullName'],
                                          style: const TextStyle(fontSize: 24,color: AppColor.white,fontFamily: AppFont.semiBold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // Text(data['department'],
                                    //     style: const TextStyle(fontSize: 12,color: Colors.white)),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreenUser()));
                                    // Get.to(const EmployeeProfileScreenUser());
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: AppColor.white.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: const Icon(Icons.edit,color: AppColor.white,)),
                                )
                            ),
                            /*Positioned(
                                left: 10,
                                top: 20,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreenUser()), (route) => false);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      decoration: BoxDecoration(
                                          color: AppColor.white.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: const Icon(Icons.arrow_back_ios_rounded,color: AppColor.white,)),
                                )
                            )*/
                          ]
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        // width: double.infinity,
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  margin: const EdgeInsets.only(left: 10,right: 00),
                                  child: const Icon(Icons.person,color: AppColor.appColor,)),
                              const SizedBox(height: 5,),
                              Expanded(
                                child: Container(
                                    // width: MediaQuery.of(context).size.width/1.5,
                                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                                    margin: const EdgeInsets.only(left: 10,right: 10),
                                    child: Text(data['fullName'],
                                      // maxLines: 2,
                                      // overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontFamily: AppFont.regular,fontSize: 17),)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        // width: double.infinity,
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  margin: const EdgeInsets.only(left: 10,right: 00),
                                  child: const Icon(Icons.email,color: AppColor.appColor,)),
                              const SizedBox(height: 5,),
                              Container(
                                  // width: MediaQuery.of(context).size.width/1.5,
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  margin: const EdgeInsets.only(left: 10,right: 10),
                                  child: Text(data['email'],
                                    // maxLines: 2,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontFamily: AppFont.regular,fontSize: 17),)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        // width: double.infinity,
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  margin: const EdgeInsets.only(left: 10,right: 00),
                                  child: const Icon(Icons.phone_iphone_rounded,color: AppColor.appColor,)),
                              const SizedBox(height: 5,),
                              Expanded(
                                child: Container(
                                    // width: MediaQuery.of(context).size.width/1.5,
                                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                                    margin: const EdgeInsets.only(left: 10,right: 10),
                                    child: Text(data['phone'],
                                      // maxLines: 2,
                                      // overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontFamily: AppFont.regular,fontSize: 17),)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*Container(
                        padding: const EdgeInsets.only(top: 10),
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        width: double.infinity,
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  margin: const EdgeInsets.only(left: 10,right: 10),
                                  child: const Icon(Icons.date_range_outlined,color: AppColor.appColor,)),
                              const SizedBox(height: 5,),
                              Container(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  margin: const EdgeInsets.only(left: 10,right: 10),
                                  child: Text(data['dob'])),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        width: double.infinity,
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  margin: const EdgeInsets.only(left: 10,right: 10),
                                  child: const Icon(Icons.location_city,color: AppColor.appColor,)),
                              const SizedBox(height: 5,),
                              Container(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  margin: const EdgeInsets.only(left: 10,right: 10),
                                  child: Text(data['address'])),
                            ],
                          ),
                        ),
                      ),*/
                      const SizedBox(height: 40),
                      GestureDetector(
                          onTap: () async {
                            SharedPreferences prefg = await SharedPreferences.getInstance();
                            prefg.clear();
                            FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                          },
                          child: Container(
                            height: 50,
                            width: 100,
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
                                child: Text("Logout",
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontFamily: AppFont.semiBold,
                                      fontSize: 20
                                  ),
                                )
                            ),
                          )
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/2.5,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  );
                }
                else{
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/2.5,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  );
                }
              }
          ),
        ),
      ),
    );
  }
}
