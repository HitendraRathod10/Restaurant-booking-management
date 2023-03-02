import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';
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

  /*notificationOnTap() async {
    // await flutterLocalNotificationsPlugin.cancelAll();
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? event) async {
      if (event != null) {
        debugPrint("notificationOnTap HomeScreenUser getInitialMessage");
        Provider.of<HomeProvider>(context,listen: false).onItemTapped(2);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenUser()));
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreenUser()), (route) => false);
        setState(() {});
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyBookingStatusScreen()), (route) => false);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("notificationOnTap HomeScreenUser onMessageOpenedApp");
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyBookingStatusScreen()));
      Provider.of<HomeProvider>(context,listen: false).onItemTapped(2);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenUser()));
    });
  }*/
  /*getNotification(context) async {
    debugPrint("getNotification HomeScreenUser start");
    await Firebase.initializeApp();
    enableIOSNotifications();
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
        debugPrint("getNotification HomeScreenUser notification != null");
      }
      var androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
      var iOSSettings = DarwinInitializationSettings(requestSoundPermission: false, requestBadgePermission: false, requestAlertPermission: false,);
      var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
      flutterLocalNotificationsPlugin.initialize(initSetttings,onDidReceiveNotificationResponse: onSelectLocalNotification);
    });
  }
  onSelectLocalNotification(payload) async {
    // await flutterLocalNotificationsPlugin.cancelAll();
    debugPrint("onSelectLocalNotification HomeScreenUser");
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyBookingStatusScreen()));
    Provider.of<HomeProvider>(context,listen: false).onItemTapped(2);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenUser()));
  }*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
    // notificationOnTap();
    // getNotification(context);
  }
  Future<void> enableIOSNotifications() async {
    debugPrint("enableIOSNotifications HomeScreenUser");
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop:  () async{
            if(Provider.of<HomeProvider>(context,listen: false).selectedIndex != 0) {
              setState(() {
                Provider.of<HomeProvider>(context,listen: false).selectedIndex = 0;
              });
              return false;
            } else {
              return true;
            }
          },
          child: Consumer<HomeProvider>(
            builder: (context, snapshot,_) {
              return snapshot.buildScreen[snapshot.selectedIndex];
            },
          ),
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
