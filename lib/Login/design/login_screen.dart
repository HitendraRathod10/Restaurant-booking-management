import 'package:flutter/material.dart';
import 'package:restaurant_booking_management/Admin/Signup/design/signup_screen_admin.dart';

import '../../utils/app_color.dart';
import '../../utils/app_font.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                            height: 112,
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
                                    style: const TextStyle(fontSize: 17),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(00, 10, 00, 00),
                                        hintText: "Email ID",
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: AppColor.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 00, 10, 00),
                                  child: TextFormField(
                                    cursorHeight: 17,
                                    style: const TextStyle(fontSize: 17),
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(00, 00, 00, 10),
                                        hintText: "Password",
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 00, 40, 00),
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
                                      color: AppColor.appColor
                                  ),
                                ),
                              onTap: (){
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
    );
  }
}
