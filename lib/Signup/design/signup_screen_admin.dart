import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Login/design/login_screen.dart';
import 'package:restaurant_booking_management/Signup/provider/signup_provider.dart';
import 'package:restaurant_booking_management/utils/app_color.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';

import '../../utils/mixin_toast.dart';

class SignupScreenAdmin extends StatefulWidget {
  const SignupScreenAdmin({Key? key}) : super(key: key);

  @override
  State<SignupScreenAdmin> createState() => _SignupScreenAdminState();
}

class _SignupScreenAdminState extends State<SignupScreenAdmin> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  FocusNode fullNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode selectUserType = FocusNode();
  RegExp passwordValidation = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1.1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                      Colors.green.shade400,
                      Colors.green.shade600,
                      Colors.green.shade800
                    ])),
                width: double.infinity,
                child: Stack(
                  children: const [
                    Positioned(
                      top: 80,
                      right: 20,
                      child: Text("Sign Up",
                          style: TextStyle(
                              color: AppColor.white,
                              fontFamily: AppFont.semiBold,
                              fontSize: 40)),
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
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 00, 20, 00),
                          child: Container(
                            height: 315,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade600,
                                  spreadRadius: 1,
                                  blurRadius: 08,
                                  blurStyle: BlurStyle.outer)
                            ], borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 00, 10, 00),
                                  child: TextFormField(
                                    cursorHeight: 17,
                                    controller: fullNameController,
                                    focusNode: fullNameNode,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (val) {
                                      FocusScope.of(context)
                                          .requestFocus(emailNode);
                                    },
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontFamily: AppFont.regular),
                                    decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(00, 10, 00, 00),
                                        hintText: "Full Name*",
                                        hintStyle: TextStyle(
                                            fontFamily: AppFont.regular),
                                        border: InputBorder.none),
                                  ),
                                ),
                                const Divider(
                                  color: AppColor.black,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 00, 10, 00),
                                  child: TextFormField(
                                    cursorHeight: 17,
                                    focusNode: emailNode,
                                    controller: emailController,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (val) {
                                      FocusScope.of(context)
                                          .requestFocus(phoneNode);
                                    },
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontFamily: AppFont.regular),
                                    decoration: const InputDecoration(
                                      hintText: "Email ID*",
                                      hintStyle: TextStyle(
                                          fontFamily: AppFont.regular),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: AppColor.black,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 00, 10, 00),
                                  child: TextFormField(
                                    cursorHeight: 17,
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    focusNode: phoneNode,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (val) {
                                      FocusScope.of(context)
                                          .requestFocus(passwordNode);
                                    },
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontFamily: AppFont.regular),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    decoration: const InputDecoration(
                                        hintText: "Phone*",
                                        hintStyle: TextStyle(
                                            fontFamily: AppFont.regular),
                                        border: InputBorder.none),
                                  ),
                                ),
                                const Divider(
                                  color: AppColor.black,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 00, 10, 00),
                                  child: Consumer<SignupProvider>(
                                      builder: (context, snapshot, _) {
                                    return TextFormField(
                                      cursorHeight: 17,
                                      controller: passwordController,
                                      focusNode: passwordNode,
                                      obscureText:
                                          snapshot.registerPswd ? true : false,
                                      onFieldSubmitted: (val) {
                                        FocusScope.of(context)
                                            .unfocus();
                                      },
                                      textInputAction: TextInputAction.done,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: AppFont.regular),
                                      decoration: InputDecoration(
                                        hintText: "Password*",
                                        hintStyle: const TextStyle(
                                            fontFamily: AppFont.regular),
                                        // contentPadding: EdgeInsets.fromLTRB(00, 15, 00, 00),
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                            highlightColor: Colors.transparent,
                                            onPressed: () {
                                              snapshot
                                                  .checkPasswordVisibility();
                                            },
                                            icon: snapshot.registerPswd == false
                                                ? const Icon(
                                                    Icons.visibility,
                                                    color: AppColor.appColor,
                                                  )
                                                : const Icon(
                                                    Icons.visibility_off,
                                                    color: AppColor.appColor)),
                                      ),
                                    );
                                  }),
                                ),
                                const Divider(
                                  color: AppColor.black,
                                ),
                                Consumer<SignupProvider>(builder:
                                    (BuildContext context, snapshot,
                                        Widget? child) {
                                  return Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 5, bottom: 5, right: 20),
                                    child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide.none)),
                                      value: snapshot.selectUserType,
                                      // validator: (value) {
                                      //   if (value == null) {
                                      //     return 'User type is required';
                                      //   }
                                      //   return null;
                                      // },
                                      hint: const Text(
                                        'Select User Type*',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: AppFont.regular),
                                      ),
                                      isExpanded: true,
                                      // isDense: true,
                                      style: const TextStyle(
                                          color: AppColor.black),
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onChanged: (String? newValue) {
                                        snapshot.selectUserType = newValue!;
                                        snapshot.getUserType;
                                      },
                                      items: snapshot.selectUserTypeList
                                          .map<DropdownMenuItem<String>>(
                                              (String userType) {
                                        return DropdownMenuItem<String>(
                                            value: userType,
                                            child: Row(
                                              children: [
                                                Text(
                                                  userType,
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontFamily:
                                                          AppFont.regular),
                                                )
                                              ],
                                            ));
                                      }).toList(),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 00, 40, 00),
                          child: InkWell(
                            // onTap: (){
                            //   debugPrint("userType is ${Provider.of<SignupProvider>(context,listen: false).selectUserType.toString()}");
                            //  if(fullNameController.text.isEmpty || emailController.text.isEmpty ||
                            //       phoneController.text.isEmpty || passwordController.text.isEmpty || phoneController.text.trim().length != 10 ||
                            //      Provider.of<SignupProvider>(context,listen: false).selectUserType == null){
                            //    showToast(toastMessage: "Please fill all required details properly");
                            //    if(phoneController.text.trim().length != 10){
                            //      FocusScope.of(context).requestFocus(phoneFocus);
                            //    }
                            //    showToast(
                            //         toastMessage: phoneController.text.trim().length != 10?"Please enter 10 digits number":"Please fill all required details"
                            //     );
                            //   }else{
                            //    if(emailController.text.contains("@") && emailController.text.contains(".")){
                            //      Provider.of<SignupProvider>(context, listen: false)
                            //          .createNewUser(
                            //          fullNameController.text,
                            //          emailController.text,
                            //          phoneController.text,
                            //          passwordController.text,
                            //          Provider.of<SignupProvider>(context,listen: false).selectUserType.toString(),
                            //          "",
                            //          context
                            //      );
                            //      Provider.of<SignupProvider>(context,listen: false).selectUserType = null;
                            //      Provider.of<SignupProvider>(context,listen: false).registerPswd = true;
                            //    }else{
                            //      showToast(toastMessage: "Please fill all required details properly");
                            //    }
                            //   }
                            // },
                         /*   onTap: () async {
                              if (fullNameController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  phoneController.text.isEmpty ||
                                  phoneController.text.trim().length != 10 ||
                                  Provider.of<SignupProvider>(context, listen: false).selectUserType == null) {
                                fullNameController.text.isEmpty ||
                                    emailController.text.isEmpty ||
                                    passwordController.text.isEmpty ||   Provider.of<SignupProvider>(context, listen: false).selectUserType == null?    showToast(
                                    toastMessage:
                                        "Please fill all required details properly") : null;
                                if (phoneController.text.trim().length != 10 &&
                                    fullNameController.text.isNotEmpty &&
                                    emailController.text.isNotEmpty) {
                                  FocusScope.of(context)
                                      .requestFocus(phoneFocus);
                                  showToast(
                                      toastMessage:
                                          "Please enter a 10-digit phone number");
                                  return ;
                                }
                              } else {
                                final token = (await FirebaseMessaging.instance
                                    .getToken())!;
                                if (emailController.text.contains("@") &&
                                    emailController.text.contains(".")) {
                                  Provider.of<SignupProvider>(context,
                                          listen: false)
                                      .createNewUser(
                                    fullNameController.text,
                                    emailController.text.trim().toLowerCase(),
                                    phoneController.text,
                                    passwordController.text,
                                    Provider.of<SignupProvider>(context,
                                            listen: false)
                                        .selectUserType
                                        .toString(),
                                    token,
                                    context,
                                  );
                                  Provider.of<SignupProvider>(context,
                                          listen: false)
                                      .selectUserType = null;
                                  Provider.of<SignupProvider>(context,
                                          listen: false)
                                      .registerPswd = true;
                                } else {
                                  showToast(
                                      toastMessage:
                                          "Please fill all required details properly");
                                }
                              }
                            },*/
                            onTap: () async {
                              // Step 1: Check if Full Name is Empty
                              if (fullNameController.text.isEmpty) {
                                showToast(toastMessage: "Please enter your full name");
                                FocusScope.of(context).requestFocus(fullNameNode);
                                return;
                              }

                              // Step 2: Check if Email is Empty
                              if (emailController.text.isEmpty) {
                                showToast(toastMessage: "Please enter your email");
                                FocusScope.of(context).requestFocus(emailNode);
                                return;
                              }

                              // Step 3: Check if Email is Valid
                              if (!emailController.text.contains("@") || !emailController.text.contains(".")) {
                                showToast(
                                    toastMessage: "Please enter a valid email address\n(example@domain.com)",
                                );
                                FocusScope.of(context).requestFocus(emailNode);
                                return;
                              }

                              // Step 6: Check if Phone Number is Empty
                              if (phoneController.text.isEmpty) {
                                showToast(toastMessage: "Please enter your phone number");
                                FocusScope.of(context).requestFocus(phoneNode);
                                return;
                              }


                              // Step 7: Check if Phone Number is a 10-digit Number
                              if (phoneController.text.trim().length != 10) {
                                showToast(toastMessage: "Please enter a 10-digit phone number");
                                FocusScope.of(context).requestFocus(phoneNode);
                                return;
                              }

                              // Step 4: Check if Password is Empty
                              if (passwordController.text.isEmpty) {
                                showToast(toastMessage: "Please enter your password");
                                FocusScope.of(context).requestFocus(passwordNode);
                                return;
                              }
                              // Step 5: Check if Password Length is Exactly 6
                              if (passwordController.text.length <= 6) {
                                showToast(toastMessage: "Password length must be at least 6");
                                FocusScope.of(context).requestFocus(passwordNode);
                                return;
                              }



                              // Step 5: Check if UserType is Selected
                              if (Provider.of<SignupProvider>(context, listen: false).selectUserType == null) {
                                FocusScope.of(context).unfocus();
                                showToast(toastMessage: "Please select a user type");
                                return;
                              }

                              // Step 6: Check if Phone Number is Empty


                              // All validations passed, proceed with user creation
                              final token = (await FirebaseMessaging.instance.getToken())!;
                              Provider.of<SignupProvider>(context, listen: false).createNewUser(
                                fullNameController.text,
                                emailController.text.trim().toLowerCase(),
                                phoneController.text,
                                passwordController.text,
                                Provider.of<SignupProvider>(context, listen: false).selectUserType.toString(),
                                token,
                                context,
                              );
                              Provider.of<SignupProvider>(context, listen: false).selectUserType = null;
                              Provider.of<SignupProvider>(context, listen: false).registerPswd = true;
                            },

                            child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.green.shade500,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Center(
                                    child: Text(
                                  "SignUp",
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 22,
                                      fontFamily: AppFont.semiBold),
                                ))),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already Have An Account? "),
                            InkWell(
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: AppColor.appColor,
                                    fontFamily: AppFont.semiBold),
                              ),
                              onTap: () {
                                Provider.of<SignupProvider>(context,
                                        listen: false)
                                    .selectUserType = null;
                                Provider.of<SignupProvider>(context,
                                        listen: false)
                                    .registerPswd = true;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
