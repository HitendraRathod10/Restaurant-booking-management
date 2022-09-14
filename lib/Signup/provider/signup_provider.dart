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

  insertDataUser(String fullName,String email,String phone,String userType)async{
    await firebase.collection("User").doc(email).set({
      "fullName" : fullName,
      "email" : email,
      "phone" : phone,
      "userType" : userType
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
      context)async{
    EasyLoading.show(status: 'loading...');
    email = email.trim();
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if(newUser != null){
        insertDataUser(fullName, email, phone, userType);
       /* if(userType == "User"){
          print("UserType $userType");
          insertDataUser(fullName, email, phone);
        }else{
          print("UserType $userType");
          insertDataAdmin(fullName, email, phone);
        }*/
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        EasyLoading.dismiss();
      }else{
        print("newUser null (createNewUser)");
      }
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