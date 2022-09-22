import 'package:flutter/material.dart';
import 'package:restaurant_booking_management/Admin/My%20Restaurants/design/update_restaurant_details.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';

import '../../../utils/app_color.dart';

class MyRestaurantOverview extends StatefulWidget {
  const MyRestaurantOverview({Key? key}) : super(key: key);

  @override
  State<MyRestaurantOverview> createState() => _MyRestaurantOverviewState();
}

class _MyRestaurantOverviewState extends State<MyRestaurantOverview> {

  showDeleteAlertDialog(BuildContext context) {
    Widget cancelButton = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey),
      child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:  const Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: AppFont.medium),
            ),
          )),
    );
    Widget continueButton = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.appColor),
      child: TextButton(
          onPressed: () {
            // Provider.of<AnonymousChatDeleteProvider>(context,listen: false).anonymousChatDeleteMethod(context, widget.groupId!);
          },
          child:  const Padding(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: AppFont.medium),
            ),
          )),
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: AppColor.white,
      titleTextStyle: const TextStyle(color: AppColor.black,fontSize: 18),
      title: const Text("Delete restaurant",style: TextStyle(fontFamily: AppFont.semiBold,fontSize: 25),),
      content: const Text("Are you sure want to delete this restaurant ?",style: TextStyle(color: AppColor.black,fontSize: 20,fontFamily: AppFont.regular)),
      actions: [
        cancelButton,
        const SizedBox(
          width: 01,
        ),
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(""),
          backgroundColor: AppColor.appColor.withOpacity(0.9),
          centerTitle: true,
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                // PopupMenuItem 1
                PopupMenuItem(
                  value: 1,
                  // row with 2 children
                  child: Row(
                    children: const [
                      Icon(Icons.edit,color: AppColor.black),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Edit")
                    ],
                  ),
                ),
                // PopupMenuItem 2
                PopupMenuItem(
                  value: 2,
                  // row with two children
                  child: Row(
                    children: const [
                      Icon(Icons.delete,color: AppColor.black,),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Delete")
                    ],
                  ),
                ),
              ],
              // offset: Offset(0, 100),
              color: AppColor.white,
              // elevation: 2,
              // on selected we show the dialog box
              onSelected: (value) {
                // if value 1 show dialog
                if (value == 1) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UpdateRestaurantDetails()));
                  // _showDialog(context);
                  // if value 2 show dialog
                } else if (value == 2) {
                  showDeleteAlertDialog(context);
                  // _showDialog(context);
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 05),
                margin: const EdgeInsets.only(left: 20,right: 20),
                width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: const Icon(Icons.food_bank,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Text("Restaurant Name")),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 05),
                margin: const EdgeInsets.only(left: 20,right: 20),
                width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: const Icon(Icons.restaurant,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Text("Food")),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 05),
                margin: const EdgeInsets.only(left: 20,right: 20),
                width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: const Icon(Icons.call,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Text("Phone no.")),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 05),
                margin: const EdgeInsets.only(left: 20,right: 20),
                width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: const Icon(Icons.mail,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Text("Email ID")),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 05),
                margin: const EdgeInsets.only(left: 20,right: 20),
                width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: const Icon(Icons.location_on,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Text("Area")),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 05),
                margin: const EdgeInsets.only(left: 20,right: 20),
                width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: const Icon(Icons.location_on,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Text("City")),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 05),
                margin: const EdgeInsets.only(left: 20,right: 20),
                width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: const Icon(Icons.location_on,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Text("State")),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 05),
                margin: const EdgeInsets.only(left: 20,right: 20),
                width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: const Icon(Icons.web,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Text("Website")),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      // snapshot.selectBarberImage(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 25),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      width: MediaQuery.of(context).size.width/2.4,
                      height: 120,
                      child: const Center(child: Text("Image")),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      // snapshot.selectBarberImage(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      width: MediaQuery.of(context).size.width/2.4,
                      height: 120,
                      child: const Center(child: Text("Map")),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
