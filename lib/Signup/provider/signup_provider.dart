import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_booking_management/Admin/Home/design/home_screen_admin.dart';
import '../../Login/design/login_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../User/Home/design/home_screen_user.dart';
import '../../utils/mixin_toast.dart';

class SignupProvider extends ChangeNotifier{
  String? userEmail,selectUserType;
  final _auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  List<String> selectUserTypeList = ['Restaurant Owner','User'];
  bool registerPswd =  true;

  get getUserType {
    notifyListeners();
    return selectUserType;
  }

  Future<bool> insertDataUser(String fullName,String email,String phone,String userType,String fcmToken)async{
    try{
      await firebase.collection("User").doc(email).set({
        "fullName" : fullName,
        "email" : email.trim().toLowerCase(),
        "phone" : phone,
        "userType" : userType,
        "fcmToken" : fcmToken
      }).then((value) {
        return true;
      });
      notifyListeners();
      return true;
    } catch(e) {
     return false;
    }

  }

  /*insertDataAdmin(String fullName,String email,String phone)async{
    await firebase.collection("Admin").doc(email).set({
      "fullName" : fullName,
      "email" : email,
      "phone" : phone
    });
    notifyListeners();
  }*/

  createNewUser(
      String fullName,
      String email,
      String phone,
      String password,
      String userType,
      String fcmToken,
      context)async{
    EasyLoading.show(status: 'loading...');
    email = email.trim().toLowerCase();
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // if(newUser != null){
        insertDataUser(fullName, email, phone, userType,fcmToken);
       /* if(userType == "User"){
          debugPrint("UserType $userType");
          insertDataUser(fullName, email, phone);
        }else{
          debugPrint("UserType $userType");
          insertDataAdmin(fullName, email, phone);
        }*/
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
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomeScreenUser()));
        }
      }

      for(var i in queryUserRatingSnapshots.docChanges){
        debugPrint("aa ${i.doc.get("userType")}");
        if(i.doc.get("userType") == "Restaurant Owner"){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomeScreenAdmin()));
        }
      }
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenAdmin()));
       showToast(toastMessage: "SignUp Successfully");
        EasyLoading.dismiss();
      // }else{
      //   debugPrint("newUser null (createNewUser)");
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        EasyLoading.dismiss();
        showToast(toastMessage: 'The password provided is too weak');
      }
      else if (e.code == 'email-already-in-use') {
        EasyLoading.dismiss();
        showToast(toastMessage: 'The account already exists for this email');
      }
    }
    notifyListeners();
  }

  checkPasswordVisibility() {
    registerPswd=!registerPswd;
    notifyListeners();
  }
}