import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Login/design/reset_password.dart';
import 'package:restaurant_booking_management/utils/mixin_toast.dart';
import '../../Signup/design/signup_screen_admin.dart';
import '../../utils/app_color.dart';
import '../../utils/app_font.dart';
import '../provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Colors.green.shade400,Colors.green.shade600,Colors.green.shade800]
                      )
                  ),
                  width: double.infinity,
                  child: Stack(
                    children: const [
                      Positioned(
                        top: 80,
                        left: 20,
                        child: Text("Log in",
                            style: TextStyle(
                                color: AppColor.white,
                                fontFamily: AppFont.semiBold,
                                fontSize: 40
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 140,
                    bottom: 00,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                            child: Container(
                              height: 115,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 08,
                                        blurStyle: BlurStyle.outer
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 00, 10, 00),
                                    child: TextFormField(
                                      cursorHeight: 17,
                                      controller: emailController,
                                      style: const TextStyle(fontSize: 17,fontFamily: AppFont.regular),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(00, 10, 00, 00),
                                          hintText: "Email ID",
                                          border: InputBorder.none,
                                        hintStyle: TextStyle(fontFamily: AppFont.regular)
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: AppColor.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 00, 10, 00),
                                    child: Consumer<LoginProvider>(
                                      builder: (context, snapshot,_) {
                                        return TextFormField(
                                          cursorHeight: 17,
                                          controller: passwordController,
                                          style: const TextStyle(fontSize: 17,fontFamily: AppFont.regular),
                                          obscureText: snapshot.loginPswd ? false : true,
                                          decoration: InputDecoration(
                                              hintText: "Password",
                                              hintStyle: const TextStyle(fontFamily: AppFont.regular),
                                              border: InputBorder.none,
                                            suffixIcon: IconButton(
                                                highlightColor: Colors.transparent,
                                                onPressed: () {
                                                  snapshot.checkPasswordVisibility();
                                                },
                                                icon: snapshot.loginPswd == false
                                                    ? const Icon(
                                                  Icons.visibility_off,
                                                  color: AppColor.appColor,
                                                )
                                                    : const Icon(
                                                    Icons.visibility,
                                                    color: AppColor.appColor
                                                )),
                                          ),
                                        );
                                      }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(00, 00, 20, 00),
                                alignment: Alignment.centerRight,
                                  child: const Text("Reset password?",
                                  style: TextStyle(
                                    fontFamily: AppFont.regular,
                                    fontSize: 17
                                  ),
                                  )
                              ),
                            onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                                Provider.of<LoginProvider>(context,listen: false).loginPswd = false;
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 00, 40, 00),
                            child: InkWell(
                              onTap: ()async{
                                if(emailController.text.isEmpty || passwordController.text.isEmpty ){
                                  showToast(
                                    toastMessage: "Please fill all required details"
                                  );
                                }else{
                                  Provider.of<LoginProvider>(context,listen: false).
                                  loginWithEmail(emailController.text, passwordController.text,context);
                                  Provider.of<LoginProvider>(context,listen: false).loginPswd = false;
                                }
                              },
                              child: Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade500,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: const Center(
                                      child: Text("Login",
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 22,
                                            fontFamily: AppFont.semiBold
                                        ),
                                      )
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't Have An Account Yet? "),
                              InkWell(
                                  child: const Text("Signup",
                                    style: TextStyle(
                                        color: AppColor.appColor,
                                        fontFamily: AppFont.semiBold
                                    ),
                                  ),
                                onTap: (){
                                    Provider.of<LoginProvider>(context,listen: false).loginPswd = false;
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupScreenAdmin()));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
