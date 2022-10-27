import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/User/All%20Restaurant%20List/design/all_restaurants_screen.dart';
import 'package:restaurant_booking_management/User/Profile/design/profile_screen_user.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Login/design/login_screen.dart';
import '../../../main.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';
import '../../Map/design/map_screen.dart';
import '../../My Booking Status/design/my_booking_status_screen.dart';
import '../provider/home_provider.dart';

class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {

  check() async {
    SharedPreferences prefg = await SharedPreferences.getInstance();
    prefg.setBool("key", true);
  }

  notificationOnTap() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? event) {
      if (event != null) {
        Provider.of<HomeProvider>(context,listen: false).onItemTapped(2);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenUser()));
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreenUser()), (route) => false);
        setState(() {});
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyBookingStatusScreen()), (route) => false);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyBookingStatusScreen()));
      Provider.of<HomeProvider>(context,listen: false).onItemTapped(2);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenUser()));
    });
  }
  getNotification(context) {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false, requestAlertPermission: false);
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid,iOS: initializationSettingsIOS,);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                icon: "@mipmap/ic_launcher",
              ),
              iOS: const DarwinNotificationDetails(),
            ));
      }
      var androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
      var iOSSettings = DarwinInitializationSettings(requestSoundPermission: false, requestBadgePermission: false, requestAlertPermission: false,);
      var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
      flutterLocalNotificationsPlugin.initialize(initSetttings,onDidReceiveNotificationResponse: onSelectLocalNotification);
    });
  }
  onSelectLocalNotification(payload) async {
    await flutterLocalNotificationsPlugin.cancelAll();
    print("method for navigation USER");
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyBookingStatusScreen()));
    Provider.of<HomeProvider>(context,listen: false).onItemTapped(2);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenUser()));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
    notificationOnTap();
    getNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomeProvider>(
          builder: (context, snapshot,_) {
            return snapshot.buildScreen[snapshot.selectedIndex];
          },
        ),
        bottomNavigationBar: Consumer<HomeProvider>(
          builder: (context, snapshot,_) {
            return BottomNavigationBar(
              // type: BottomNavigationBarType.shifting,
              currentIndex: snapshot.selectedIndex,
              backgroundColor: AppColor.white,
              selectedFontSize: 14,
              selectedLabelStyle: const TextStyle(color: AppColor.appColor,fontFamily: AppFont.semiBold),
              unselectedLabelStyle: const TextStyle(color: AppColor.blackColor,fontFamily: AppFont.regular),
              selectedItemColor: AppColor.appColor,
              unselectedItemColor: AppColor.blackColor,
              showSelectedLabels: false,
              onTap: snapshot.onItemTapped,
              items:  [
                BottomNavigationBarItem(
                    label: "Home",
                    icon:  Image.asset(AppImage.home,height: 25,width: 25),
                ),
                BottomNavigationBarItem(
                    label: "Near By",
                    icon: Image.asset(AppImage.map,height: 25,width: 25)
                ),
                BottomNavigationBarItem(
                    label: "My Booking",
                    icon: Image.asset(AppImage.histroyTwo,height: 25,width: 25)
                ),
                BottomNavigationBarItem(
                    label: "Profile",
                    icon: Image.asset(AppImage.profile,height: 25,width: 25)
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
