import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_color.dart';

void showToast({String? toastMessage, Color? backgroundColor, Color? textColor,Toast? toastLength}) {
  Fluttertoast.showToast(
      msg: toastMessage!,
      backgroundColor: backgroundColor ?? AppColor.appColor,
      textColor: textColor ?? AppColor.white,
      toastLength: toastLength??Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM);
}