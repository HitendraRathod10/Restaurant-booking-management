import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/Add%20Restaurant/provider/add_restaurant_provider.dart';
import 'package:restaurant_booking_management/Login/provider/login_provider.dart';
import 'package:restaurant_booking_management/Login/provider/reset_password_provider.dart';
import 'package:restaurant_booking_management/Signup/provider/signup_provider.dart';
import 'package:restaurant_booking_management/Splash/design/splash_screen.dart';
import 'Login/design/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => ResetPasswordProvider()),
        ChangeNotifierProvider(create: (context) => AddRestaurantProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  const SplashSceen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}


