import 'package:flutter/material.dart';
import 'package:restaurant_booking_management/Login/provider/reset_password_provider.dart';
import 'package:restaurant_booking_management/utils/app_color.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';
import '../../Signup/design/signup_screen_admin.dart';
import '../../utils/mixin_textformfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    child: const Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Reset Your Password",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 16, color: AppColor.appColor),
                  ),
                  const SizedBox(height: 5),
                  TextFieldMixin().textFieldWidget(
                    cursorColor: Colors.black,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Enter email",
                    prefixIcon: const Icon(Icons.email_outlined,
                        color: AppColor.appColor),
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.trim().isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@"
                                  r"[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<ResetPasswordProvider>(context,
                                  listen: false)
                              .resetPassword(email: emailController.text);
                        }
                      },
                      child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColor.appColor,
                              borderRadius: BorderRadius.circular(05)),
                          alignment: Alignment.center,
                          child: const Text(
                            "Reset Password",
                            style:
                                TextStyle(color: AppColor.white, fontSize: 15),
                          ))),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't Have An Account Yet? "),
                      InkWell(
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                              color: AppColor.appColor,
                              fontFamily: AppFont.semiBold),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SignupScreenAdmin()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
