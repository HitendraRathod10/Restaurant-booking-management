import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_booking_management/User/All%20Restaurant%20List/design/all_restaurants_screen.dart';
import 'package:restaurant_booking_management/User/Profile/design/profile_screen_user.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Login/design/login_screen.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';
import '../../Map/design/map_screen.dart';
import '../../My Booking Status/design/my_booking_status_screen.dart';

class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {

  int _selectedIndex=0;

  List<Widget> buildScreen(){
    return [
      const AllRestaurantsScreen(),
      const MapScreen(),
      const MyBookingStatusScreen(),
      const ProfileScreenUser()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  check() async {
    SharedPreferences prefg = await SharedPreferences.getInstance();
    prefg.setBool("key", true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildScreen().elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          // type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          backgroundColor: AppColor.white,
          selectedFontSize: 14,
          selectedLabelStyle: const TextStyle(color: AppColor.appColor,fontFamily: AppFont.semiBold),
          unselectedLabelStyle: const TextStyle(color: AppColor.blackColor,fontFamily: AppFont.regular),
          selectedItemColor: AppColor.appColor,
          unselectedItemColor: AppColor.blackColor,
          showSelectedLabels: false,
          onTap: _onItemTapped,
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
        ),
      ),
    );
  }
}
