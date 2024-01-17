import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/My%20Restaurants/design/update_restaurant_details.dart';
import 'package:restaurant_booking_management/Admin/My%20Restaurants/provider/update_restaurant_details_provider.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';

import '../../../utils/app_color.dart';
//ignore: must_be_immutable
class MyRestaurantOverview extends StatefulWidget {
  DocumentSnapshot? doc;
  MyRestaurantOverview({super.key, required this.doc});
  // const MyRestaurantOverview({Key? key}) : super(key: key);

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
            Provider.of<UpdateRestaurantDetailsProvider>(context,listen: false).deleteInMyRestaurant(widget.doc!.id,context);
            Provider.of<UpdateRestaurantDetailsProvider>(context,listen: false).deleteInAllRestaurant(widget.doc!.id,context);
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

  final Set<Marker> markers = {};
  late GoogleMapController mapController;
  double? latitudeDouble;
  double? longitudeDouble;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    latitudeDouble = double.parse(widget.doc!.get("latitude"));
    longitudeDouble = double.parse(widget.doc!.get("longitude"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text("${widget.doc!.get("name")}"),
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
                      Text("Edit",style: TextStyle(fontFamily: AppFont.regular),)
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
                      Text("Delete",style: TextStyle(fontFamily: AppFont.regular))
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateRestaurantDetails(id: widget.doc!.id,)));
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
                // width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 00),
                          child: const Icon(Icons.food_bank,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: Text("${widget.doc!.get("name")}",
                              style: const TextStyle(
                                fontFamily: AppFont.regular,
                                fontSize: 17
                              ),
                            )),
                      ),
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
                          margin: const EdgeInsets.only(left: 10,right: 00),
                          child: const Icon(Icons.restaurant,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: Text("${widget.doc!.get("food")}",
                              style: const TextStyle(
                                  fontFamily: AppFont.regular,
                                  fontSize: 17
                              ),
                            )),
                      ),
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
                          margin: const EdgeInsets.only(left: 10,right: 00),
                          child: const Icon(Icons.call,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: Text("${widget.doc!.get("phone")}",
                                style: const TextStyle(
                                fontFamily: AppFont.regular,
                                fontSize: 17
                            ),
                            )),
                      ),
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
                          margin: const EdgeInsets.only(left: 10,right: 00),
                          child: const Icon(Icons.mail,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: Text("${widget.doc!.get("email")}",
                              style: const TextStyle(
                                  fontFamily: AppFont.regular,
                                  fontSize: 17
                              ),
                            )),
                      ),
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
                          margin: const EdgeInsets.only(left: 10,right: 00),
                          child: const Icon(Icons.location_on,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: Text("${widget.doc!.get("area")}",
                              style: const TextStyle(
                                  fontFamily: AppFont.regular,
                                  fontSize: 17
                              ),
                            )),
                      ),
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
                          margin: const EdgeInsets.only(left: 10,right: 00),
                          child: const Icon(Icons.location_on,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: Text("${widget.doc!.get("city")}",
                              style: const TextStyle(
                                  fontFamily: AppFont.regular,
                                  fontSize: 17
                              ),
                            )),
                      ),
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
                          margin: const EdgeInsets.only(left: 10,right: 00),
                          child: const Icon(Icons.location_on,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: Text("${widget.doc!.get("state")}",
                              style: const TextStyle(
                                  fontFamily: AppFont.regular,
                                  fontSize: 17
                              ),
                            )),
                      ),
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
                          margin: const EdgeInsets.only(left: 10,right: 00),
                          child: const Icon(Icons.web,color: AppColor.appColor,)),
                      const SizedBox(height: 5,),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: widget.doc!.get("website") == "" ?
                            const Text("Not added",
                              style: TextStyle(
                                  fontFamily: AppFont.regular,
                                  fontSize: 17
                              ),
                            ) :
                            Text("${widget.doc!.get("website")}",
                              style: const TextStyle(
                                  fontFamily: AppFont.regular,
                                  fontSize: 17
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
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
                      child: Image.network("${widget.doc!.get("image")}",fit: BoxFit.fill),
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
                      child: GoogleMap(
                        // zoomControlsEnabled: false,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitudeDouble!,longitudeDouble!),
                          zoom: 10.0,
                        ),
                        markers: markers,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
