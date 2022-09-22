import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class AddRestaurantProvider extends ChangeNotifier{
  File? barberFile,shopImage,coverShopImage;
  String? barberImageName;
  String latitude="";
  String longitude="";

  //Compress Image File
  Future<File> imageSizeCompress(
      {required File image, quality = 100, percentage = 70}) async {
    var path = await FlutterNativeImage.compressImage(image.absolute.path,quality: 100,percentage: 70);
    return path;
  }

  //Pick Image File
  void selectBarberImage(BuildContext context) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image
    );
    if(result == null) return;
    final filePath = result.files.single.path;
    File compressImage = await imageSizeCompress(image: File(filePath!));
    barberFile = compressImage;
    barberImageName = result.files.first.name;
    notifyListeners();
  }

}