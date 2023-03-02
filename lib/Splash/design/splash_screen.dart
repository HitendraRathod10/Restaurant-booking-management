import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_booking_management/Admin/Home/design/home_screen_admin.dart';
import 'package:restaurant_booking_management/Login/design/login_screen.dart';
import 'package:restaurant_booking_management/User/Home/design/home_screen_user.dart';
import 'package:restaurant_booking_management/utils/app_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashSceen extends StatefulWidget {
  const SplashSceen({Key? key}) : super(key: key);

  @override
  State<SplashSceen> createState() => _SplashSceenState();
}

class _SplashSceenState extends State<SplashSceen> {

  checkLogin() async {
    // await flutterLocalNotificationsPlugin.cancelAll();
    SharedPreferences prefg = await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 3), ()
    async{
      if (prefg.containsKey("key")) {
        final firebase = FirebaseFirestore.instance;

        var queryUserRatingSnapshots = await firebase.collection("User").
        where('email',isEqualTo: FirebaseAuth.instance.currentUser!.email).
        where('userType',isEqualTo: "Restaurant Owner").get();

        var queryUserRatingSnapshotsOne = await firebase.collection("User").
        where('email',isEqualTo: FirebaseAuth.instance.currentUser!.email).
        where('userType',isEqualTo: "User").get();

        for(var i in queryUserRatingSnapshotsOne.docChanges){
          debugPrint("aa ${i.doc.get("userType")}");
          if(i.doc.get("userType") == "User"){
            if (!mounted) return;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const HomeScreenUser()));
          }
        }

        for(var i in queryUserRatingSnapshots.docChanges){
          debugPrint("aa ${i.doc.get("userType")}");
          if(i.doc.get("userType") == "Restaurant Owner"){
            if (!mounted) return;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const HomeScreenAdmin()));
          }
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
    // PushNotificationService().getNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff518e4f),
        body: Center(
          child: Image.asset(AppImage.splashImageFinal,),
        ),
      ),
    );
  }
}
