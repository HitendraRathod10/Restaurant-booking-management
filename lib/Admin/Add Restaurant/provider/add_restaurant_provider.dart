import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:permission_handler/permission_handler.dart';

class AddRestaurantProvider extends ChangeNotifier{
  File? restaurantImageFile;
  String? restaurantImageName;
  String latitude="";
  String longitude="";
  final firebase = FirebaseFirestore.instance;
  String? urlDownloads;
  bool isLoading = false;

  //Compress Image File
  Future<File> imageSizeCompress(
      {required File image, quality = 100, percentage = 70}) async {
    var path = await FlutterNativeImage.compressImage(image.absolute.path,quality: 100,percentage: 70);
    return path;
  }

  // Pick Image File
  void selectBarberImage(BuildContext context) async{
    final status = await Permission.storage.status;
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      await Permission.storage.request();
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image
    );
    if(result == null) return;
    if(urlDownloads!="" && restaurantImageFile!=null){
      urlDownloads = "";
      restaurantImageFile = null;
      notifyListeners();
    }
    isLoading = true;
    notifyListeners();
    final filePath = result.files.single.path;
    File compressImage = await imageSizeCompress(image: File(filePath!));
    restaurantImageFile = compressImage;
    restaurantImageName = result.files.first.name;
    final destination = 'images/$restaurantImageName';
    debugPrint("restaurantImageName :- $restaurantImageName");
 try{
   final ref = FirebaseStorage.instance.ref().child(destination).putFile(restaurantImageFile!);
   final snapshot = await ref.whenComplete(() {});
   urlDownloads = await snapshot.ref.getDownloadURL().whenComplete(() {});
   isLoading = false;
 }catch (e){
isLoading = false;
 }
    // if(urlDownloads!.isNotEmpty){
    //   isLoading = false;
    //   notifyListeners();
    // }
    print("isLoading :$isLoading");
    notifyListeners();
  }

  insertALLRestaurant(
      context,
      String shopOwnerEmail,
      String name,
      String food,
      String phone,
      String email,
      String area,
      String city,
      String state,
      String website,
      String image,
      String latitude,
      String longitude,
      double rating
      ) async {
    await firebase.collection("All Restaurants").doc(name).set({
      "shopOwnerEmail" : shopOwnerEmail,
      "name" : name,
      "food" : food,
      "phone" : phone,
      "email" : email,
      "area" : area,
      "city" : city,
      "state" : state,
      "website" : website,
      "image" : image,
      "latitude" : latitude,
      "longitude" : longitude,
      "rating" : rating
    });
    // showToast(
    //   toastMessage: "Restaurant added successfully"
    // );
    // insertMyRestaurant(shopOwnerEmail,name,food,phone,email,area,city,state,website,image,latitude,longitude);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenAdmin()));
    notifyListeners();
  }

  insertMyRestaurant(
      String? shopOwnerEmail,
      String name,
      String food,
      String phone,
      String email,
      String area,
      String city,
      String state,
      String website,
      String image,
      String latitude,
      String longitude,
      double rating
      ) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('My Restaurants')
        .doc(name)
        .set({
      "userEmail" : shopOwnerEmail,
      "name" : name,
      "food" : food,
      "phone" : phone,
      "email" : email,
      "area" : area,
      "city" : city,
      "state" : state,
      "website" : website,
      "image" : image,
      "latitude" : latitude,
      "longitude" : longitude,
      "rating" : rating
    });
    notifyListeners();
  }

}