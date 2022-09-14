
import 'package:flutter/material.dart';

import 'app_font.dart';


Widget dashboardDetailsWidget(
    String imageLocation, String title, String description,Color color) {
  return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
      ),

      child: Container(
        padding: const EdgeInsets.only(left: 5),
        height: 150,
        decoration:  BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
          // gradient:  LinearGradient(
          //   colors: [
          //     Colors.white,
          //     color,
          //   ],
          //   begin: const FractionalOffset(0.1, 0.5),
          //   end: const FractionalOffset(0.2, 1.5),
          //   stops: const [0.0, 1.0],
          //   tileMode: TileMode.clamp,
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only( top: 10),
                  child: Image.asset(imageLocation,
                      height: 60, width: 60, fit: BoxFit.contain),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,),
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: AppFont.medium),
                      textAlign: TextAlign.start),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5),
                  child: Text(description,
                      style: const TextStyle(
                          fontSize: 12, fontFamily: AppFont.medium),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ],
        ),
      ));
}