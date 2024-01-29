import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../utils/mixin_toast.dart';
import '../../Home/design/home_screen_admin.dart';

class UpdateRestaurantDetailsProvider extends ChangeNotifier{
  final firebase = FirebaseFirestore.instance;
  File? restaurantImageFile;
  String? restaurantImageName;
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController foodController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  String? image;
  String? latitude;
  String? longitude;
  DocumentSnapshot? querySnapshots;
  String? urlDownloads;
  bool isLoading = false;

  getData(String id)async{
    CollectionReference  collection = firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("My Restaurants");
    querySnapshots = await collection.doc(id).get();
    debugPrint("querySnapshots $querySnapshots");
    restaurantNameController.text = querySnapshots!.get("name");
    foodController.text = querySnapshots!.get("food");
    phoneController.text = querySnapshots!.get("phone");
    emailController.text = querySnapshots!.get("email");
    areaController.text = querySnapshots!.get("area");
    cityController.text = querySnapshots!.get("city");
    stateController.text = querySnapshots!.get("state");
    websiteController.text = querySnapshots!.get("website");
    image = querySnapshots!.get("image");
    latitude = querySnapshots!.get("latitude");
    longitude = querySnapshots!.get("longitude");
    notifyListeners();
  }

  //Compress Image File
  Future<File> imageSizeCompress({required File image, quality = 100, percentage = 70}) async {
    var path = await FlutterNativeImage.compressImage(image.absolute.path,quality: 100,percentage: 70);
    return path;
  }

  //Pick Image File
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
    isLoading =true;
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
    }catch(e){
      isLoading = false;
    }
    print("ISLOADING :- $isLoading");
    notifyListeners();
  }

  updateInALLRestaurant(
      context,
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
      String id
      ) async {
    await firebase.collection("All Restaurants").doc(id).update({
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
      "id" : id,
      "rating" : 0.1
    });
    showToast(
        toastMessage: "Restaurant details updated successfully"
    );
    updateInMyRestaurant(name,food,phone,email,area,city,state,website,image,latitude,longitude,id);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenAdmin()));
    notifyListeners();
  }

  updateInMyRestaurant(
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
      String id
      ) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('My Restaurants')
        .doc(id)
        .update({
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
      "id" : id,
      "rating" : 0.1
    });
    notifyListeners();
  }

  deleteInMyRestaurant(String id,context){
    firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("My Restaurants").doc(id).delete();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeScreenAdmin()), (route) => false);
  }

  deleteInAllRestaurant(String id,context){
    firebase.collection('All Restaurants').doc(id).delete();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeScreenAdmin()), (route) => false);
  }
}