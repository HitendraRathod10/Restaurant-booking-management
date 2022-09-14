import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class TextFieldMixin {
  Widget textFieldWidget({TextEditingController? controller,
    Color? cursorColor,
    TextInputAction? textInputAction,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    Widget? prefixIcon,
    void Function()? onTap,
    Widget? suffixIcon,
    InputBorder? border,
    int? maxLines = 1,
    int? maxLength,
    String? prefixText,
    String? counterText,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
    String? initialValue,
    bool readOnly = false,
    String? hintText,
    bool obscureText = false,
    InputBorder? focusedBorder,
    String? labelText,
    TextStyle? labelStyle
  }) {
    return TextFormField(
      decoration: InputDecoration(
          isDense: false,
          filled: true,
          labelText: labelText,
          fillColor: Colors.white,
          // fillColor: AppColor.blackColor.withOpacity(0.1),
          labelStyle: labelStyle,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.appColor),borderRadius: BorderRadius.circular(10)),
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.redColor.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.appColor),
              borderRadius: BorderRadius.circular(10)
          ),
          hintText: hintText,
          counterText: counterText,
          errorStyle: const TextStyle(
            fontSize: 12.0,

          ),
          prefixText: prefixText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon
      ),
      readOnly: readOnly,
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      maxLines: maxLines,
      obscureText: obscureText,
      maxLength: maxLength,
    );
  }
}