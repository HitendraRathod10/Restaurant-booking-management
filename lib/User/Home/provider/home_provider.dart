import 'package:flutter/material.dart';
import 'package:restaurant_booking_management/User/All%20Restaurant%20List/design/all_restaurants_screen.dart';
import 'package:restaurant_booking_management/User/Map/design/map_screen.dart';

import '../../My Booking Status/design/my_booking_status_screen.dart';
import '../../Profile/design/profile_screen_user.dart';

class HomeProvider extends ChangeNotifier{

  int selectedIndex=0;

  List<Widget> buildScreen =
   [
      const AllRestaurantsScreen(),
      const MapScreen(),
      const MyBookingStatusScreen(),
      const ProfileScreenUser()
    ];


  void onItemTapped(int index) {
    // setState(() {
      selectedIndex = index;
      notifyListeners();
    // });
  }


}