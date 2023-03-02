import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Login/design/login_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  insertDataUser(String fullName,String email,String phone,String userType,String fcmToken)async{
    await firebase.collection("User").doc(email).set({
      "fullName" : fullName,
      "email" : email,
      "phone" : phone,
      "userType" : userType,
      "fcmToken" : fcmToken
    });
    notifyListeners();
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
    email = email.trim();
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
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