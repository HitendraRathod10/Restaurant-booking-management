import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  
  checkPasswordVisibility() {
    loginPswd=!loginPswd;
    notifyListeners();
  }

  loginWithEmail(String email,String password,context) async{
    // loginPswd = false;
    EasyLoading.show(status: 'loading...');
    try {
      email = email.trim();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      showToast(toastMessage: "Login successfully",backgroundColor: AppColor.appColor,textColor: AppColor.white);

      final firebase = FirebaseFirestore.instance;

      var queryUserRatingSnapshots = await firebase.collection("User").
      where('email',isEqualTo: FirebaseAuth.instance.currentUser!.email).
      where('userType',isEqualTo: "Restaurant Owner").get();

      var queryUserRatingSnapshotsOne = await firebase.collection("User").
      where('email',isEqualTo: FirebaseAuth.instance.currentUser!.email).
      where('userType',isEqualTo: "User").get();

      for(var i in queryUserRatingSnapshotsOne.docChanges){
        if(i.doc.get("userType") == "User"){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreenUser()));
        }
      }

      for(var i in queryUserRatingSnapshots.docChanges){
        if(i.doc.get("userType") == "Restaurant Owner"){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreenAdmin()));
        }
      }

    } on Exception catch (e) {
      EasyLoading.showToast("Your email or password is invalid !!",
        toastPosition: EasyLoadingToastPosition.bottom,
      );
    }
    EasyLoading.dismiss();
  }
}