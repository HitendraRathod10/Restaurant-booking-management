import 'package:flutter/material.dart';
import 'package:restaurant_booking_management/utils/app_image.dart';

class SplashSceen extends StatefulWidget {
  const SplashSceen({Key? key}) : super(key: key);

  @override
  State<SplashSceen> createState() => _SplashSceenState();
}

class _SplashSceenState extends State<SplashSceen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(AppImage.splashImage,),
        ),
      ),
    );
  }
}
