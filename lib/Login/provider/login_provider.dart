import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:restaurant_booking_management/utils/app_color.dart';
import 'package:restaurant_booking_management/utils/mixin_toast.dart';
import '../../Admin/Home/design/home_screen_admin.dart';
import '../../User/Home/design/home_screen_user.dart';

class LoginProvider extends ChangeNotifier{
  final _auth = FirebaseAuth.instance;
  bool loginPswd =  false;
  final firebase = FirebaseFirestore.instance;
  String? token;
  FocusNode focusNode = FocusNode();

  getToken() async {

  }
  
  checkPasswordVisibility() {
    loginPswd=!loginPswd;
    notifyListeners();
  }

  loginWithEmail(String email,String password,context) async{
    // loginPswd = false;
    FocusScope.of(context).unfocus();
    EasyLoading.show(status: 'loading...');
    try {
      email = email.trim();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      showToast(toastMessage: "Login successfully",backgroundColor: AppColor.appColor,textColor: AppColor.white);
      final firebase = FirebaseFirestore.instance;
      token = (await FirebaseMessaging.instance.getToken())!;
      debugPrint('Token => $token');

      var dataName = await firebase.collection('User').get();
      for(var i in dataName.docChanges){
        if(i.doc.get('email') == FirebaseAuth.instance.currentUser!.email){
          await FirebaseFirestore.instance.
          collection("User").
          doc(FirebaseAuth.instance.currentUser!.email).set(({
            "email" : FirebaseAuth.instance.currentUser!.email!,
            "fcmToken" : token,
            "fullName" : i.doc.get('fullName'),
            "phone" : i.doc.get('phone'),
            "userType" : i.doc.get('userType')
          }));
          break;
        }
      }

      var queryUserRatingSnapshots = await firebase.collection("User").
      where('email',isEqualTo: FirebaseAuth.instance.currentUser!.email).
      where('userType',isEqualTo: "Restaurant Owner").get();

      var queryUserRatingSnapshotsOne = await firebase.collection("User").
      where('email',isEqualTo: FirebaseAuth.instance.currentUser!.email).
      where('userType',isEqualTo: "User").get();

      for(var i in queryUserRatingSnapshotsOne.docChanges){
        if(i.doc.get("userType") == "User"){
          print("userType 0 :- ${i.doc.get("userType")}");
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => const HomeScreenUser()),(route) => false);
        }
      }

      for(var i in queryUserRatingSnapshots.docChanges){
        if(i.doc.get("userType") == "Restaurant Owner"){
          print("userType 1 :- ${i.doc.get("userType")}");

          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => const HomeScreenAdmin()),(route) => false);
        }
      }


    } on Exception {
      EasyLoading.showToast("Your email or password is invalid !!",
        toastPosition: EasyLoadingToastPosition.bottom,
      ).then((_){
        Future.delayed(Duration(milliseconds: 1000),() =>  FocusScope.of(context).requestFocus(focusNode),);
      } );
    }
    EasyLoading.dismiss();
  }
}