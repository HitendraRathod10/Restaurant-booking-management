import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_booking_management/User/Home/design/home_screen_user.dart';

import '../../../utils/mixin_toast.dart';

class RestaurantBookProvider extends ChangeNotifier{

  final firebase = FirebaseFirestore.instance;

  bookTable(
    context,
    String? email,
    String? person,
    String? date,
    String? time,
    String? restaurantName,
    String? statusOfBooking,
    String? userName,
    String? shopOwnerEmail
  ) async {
    await firebase.collection("Booking").doc("$restaurantName $date $time $email").set({
      "email" : email,
      "person" : person,
      "date" : date,
      "time" : time,
      "shopOwnerEmail" : shopOwnerEmail,
      "restaurantName" : restaurantName,
      "statusOfBooking" : statusOfBooking,
      "userName" : userName
    });
    showToast(
        toastMessage: "Your request for booking table added successfully."
    );
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreenUser()),(route) => false);
    // forMyBooking(context,email,person,date,time,restaurantName,statusOfBooking,userName);
    notifyListeners();
  }

/*  forMyBooking(
        context,
        String? email,
        String? person,
        String? date,
        String? time,
        String? restaurantName,
        String? statusOfBooking,
        String? userName
      ) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('My Booking')
        .doc("$restaurantName $date $time")
        .set({
      "email" : email,
      "person" : person,
      "date" : date,
      "time" : time,
      "restaurantName" : restaurantName,
      "statusOfBooking" : statusOfBooking,
      "userName" : userName
    });
  }*/
}