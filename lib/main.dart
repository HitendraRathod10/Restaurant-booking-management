import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/Add%20Restaurant/provider/add_restaurant_provider.dart';
import 'package:restaurant_booking_management/Admin/My%20Restaurants/provider/update_restaurant_details_provider.dart';
import 'package:restaurant_booking_management/Login/provider/login_provider.dart';
import 'package:restaurant_booking_management/Login/provider/reset_password_provider.dart';
import 'package:restaurant_booking_management/Signup/provider/signup_provider.dart';
import 'package:restaurant_booking_management/Splash/design/splash_screen.dart';
import 'package:restaurant_booking_management/User/Home/provider/home_provider.dart';
import 'package:restaurant_booking_management/User/Restaurant%20Book/provider/restaurant_book_provider.dart';
import 'package:restaurant_booking_management/User/Restaurant%20Overview/provider/restaurant_overview_provider.dart';
import 'Login/design/login_screen.dart';
import 'Services/PushNotificationService.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications',
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, badge: true, sound: true,
  );
  // await PushNotificationService().setupInteractedMessage();
  runApp(const MyApp());
  /*RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // App received a notification when it was killed
  }*/
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
        ChangeNotifierProvider(create: (context) => UpdateRestaurantDetailsProvider()),
        ChangeNotifierProvider(create: (context) => RestaurantBookProvider()),
        ChangeNotifierProvider(create: (context) => RestaurantOverviewProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
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


