import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/User/All%20Restaurant%20List/design/all_restaurants_screen.dart';
import 'package:restaurant_booking_management/User/Profile/design/profile_screen_user.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Login/design/login_screen.dart';
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

  notificationOnTap(){
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? event) {
      if (event != null) {
        Provider.of<HomeProvider>(context,listen: false).onItemTapped(2);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreenUser()));
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreenUser()), (route) => false);
        setState(() {});
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyBookingStatusScreen()), (route) => false);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
    notificationOnTap();
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
