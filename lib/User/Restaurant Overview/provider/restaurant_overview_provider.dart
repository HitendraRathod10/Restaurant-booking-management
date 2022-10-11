import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantOverviewProvider extends ChangeNotifier{
  final firebase = FirebaseFirestore.instance;

  addRating(
      String? userEmail,
      String? userName,
      double rating,
      String? restaurantName,
      // String? restaurantOwnerName,
      String? feedback
      ) async {
    await firebase.collection("Rating").doc("$userEmail $restaurantName").set({
      "userEmail" : userEmail,
      "userName" : userName,
      "rating" : rating,
      "restaurantName" : restaurantName,
      // "restaurantOwnerName" : restaurantOwnerName,
      "feedback" : feedback
    });

    notifyListeners();
  }
}