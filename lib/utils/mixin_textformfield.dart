import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    // int? minLines = 1,
    int? maxLength,
    String? prefixText,
    String? counterText,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
    String? initialValue,
    bool readOnly = false,
    String? hintText,
    TextStyle? hintStyle,
    bool obscureText = false,
    InputBorder? focusedBorder,
    String? labelText,
    TextStyle? labelStyle,
    TextStyle? textStyle,
    Function? onChanged,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
          hintStyle: hintStyle,
          counterText: counterText,
          errorStyle: const TextStyle(
            fontSize: 12.0,

          ),
          prefixText: prefixText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon
      ),
      onChanged: (value) {
        onChanged?.call(value);
      },
      readOnly: readOnly,
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      maxLines: maxLines,
      minLines: 1,
      obscureText: obscureText,
      maxLength: maxLength,
      style: textStyle,
      inputFormatters: inputFormatters,
    );
  }
}