import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/Add%20Restaurant/provider/add_restaurant_provider.dart';
import 'package:restaurant_booking_management/Admin/My%20Restaurants/provider/update_restaurant_details_provider.dart';
import 'package:restaurant_booking_management/Admin/Permission/design/permission_screen_admin.dart';
import 'package:restaurant_booking_management/Login/provider/login_provider.dart';
import 'package:restaurant_booking_management/Login/provider/reset_password_provider.dart';
import 'package:restaurant_booking_management/Signup/provider/signup_provider.dart';
import 'package:restaurant_booking_management/Splash/design/splash_screen.dart';
import 'package:restaurant_booking_management/User/Home/provider/home_provider.dart';
import 'package:restaurant_booking_management/User/Restaurant%20Book/provider/restaurant_book_provider.dart';
import 'package:restaurant_booking_management/User/Restaurant%20Overview/provider/restaurant_overview_provider.dart';
import 'Services/push_notification_service.dart';
import 'User/Home/design/home_screen_user.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Handling a background message ${message.messageId} main.dart');
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
  // await PushNotificationService().setupInteractedMessage();
  await PushNotificationService().getNotification();
  runApp(const MyApp());
  await FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? event) async {
    if (event != null) {
      if(event.data.values.first == "userToOwner"){
        navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context)=>const PermissionScreenAdmin()));
      }
      if(event.data.values.first == "OwnerToUser"){
        debugPrint("on the way");
        Provider.of<HomeProvider>(navigatorKey.currentState!.context,listen: false).onItemTapped(2);
        navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreenUser()));
      }
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if(message.data.values.first == "userToOwner"){
      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context)=>const PermissionScreenAdmin()));
    }
    if(message.data.values.first == "OwnerToUser"){
      debugPrint("on the way user booking");
      Provider.of<HomeProvider>(navigatorKey.currentState!.context,listen: false).onItemTapped(2);
      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreenUser()));
    }
  });
  var androidSettings = const AndroidInitializationSettings('mipmap/ic_launcher');
  var iOSSettings = const DarwinInitializationSettings(requestSoundPermission: false, requestBadgePermission: false, requestAlertPermission: false);
  var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
  flutterLocalNotificationsPlugin.initialize(initSetttings,onDidReceiveNotificationResponse: onSelectLocalNotification);
}
onSelectLocalNotification(payload) async {
  debugPrint("onSelectLocalNotification main.dart");
  var queryUserRatingSnapshots = await FirebaseFirestore.instance.collection("User").
  where('email',isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
  for(var i in queryUserRatingSnapshots.docChanges){
    if(i.doc.get("userType") == "User"){
      Provider.of<HomeProvider>(navigatorKey.currentState!.context,listen: false).onItemTapped(2);
      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreenUser()));
    }else{
      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context)=>const PermissionScreenAdmin()));
    }
  }
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
        navigatorKey: navigatorKey,
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


