import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/mixin_toast.dart';

class ResetPasswordProvider extends ChangeNotifier{

  Future resetPassword({required String email,required BuildContext context}) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email).then((value) {
          showToast(toastMessage: 'sent a reset password link on your gmail account');
          Navigator.of(context).pop();
    }).catchError((e) {
      showToast(toastMessage: 'No user found that email');
    });
    notifyListeners();
  }
}
