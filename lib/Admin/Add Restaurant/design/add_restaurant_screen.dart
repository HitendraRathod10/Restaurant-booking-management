import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/Add%20Restaurant/provider/add_restaurant_provider.dart';
import 'package:restaurant_booking_management/utils/app_color.dart';
import 'package:restaurant_booking_management/utils/mixin_textformfield.dart';

import '../../../utils/app_font.dart';
import '../../../utils/mixin_toast.dart';
import '../provider/current_location.dart';
import 'add_location_to_map_screen.dart';

class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({Key? key}) : super(key: key);

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {

  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController foodController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final Set<Marker> markers = {};
  late GoogleMapController mapController;
  final _formKey = GlobalKey<FormState>();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Restaurant"),
          backgroundColor: AppColor.appColor.withOpacity(0.9),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 00),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: restaurantNameController,
                    textInputAction: TextInputAction.next,
                    cursorColor: AppColor.appColor,
                    decoration: const InputDecoration(
                      labelText: 'Restaurant Name',
                      labelStyle: TextStyle(
                          color: AppColor.greyDivider,
                          fontFamily: AppFont.regular),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return '* required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: foodController,
                    textInputAction: TextInputAction.next,
                    cursorColor: AppColor.appColor,
                    decoration: const InputDecoration(
                      labelText: 'Food',
                      labelStyle: TextStyle(
                          color: AppColor.greyDivider,
                          fontFamily: AppFont.regular),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return '* required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    cursorColor: AppColor.appColor,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone no.',
                      labelStyle: TextStyle(
                          color: AppColor.greyDivider,
                          fontFamily: AppFont.regular),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return '* required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    cursorColor: AppColor.appColor,
                    decoration: const InputDecoration(
                      labelText: 'Email ID',
                      labelStyle: TextStyle(
                          color: AppColor.greyDivider,
                          fontFamily: AppFont.regular),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return '* required';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2.4,
                        child: TextFormField(
                          controller: areaController,
                          textInputAction: TextInputAction.next,
                          cursorColor: AppColor.appColor,
                          decoration: const InputDecoration(
                            labelText: 'Area',
                            labelStyle: TextStyle(
                                color: AppColor.greyDivider,
                                fontFamily: AppFont.regular),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty) {
                              return '* required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: TextFormField(
                          controller: cityController,
                          textInputAction: TextInputAction.next,
                          cursorColor: AppColor.appColor,
                          decoration: const InputDecoration(
                            labelText: 'City',
                            labelStyle: TextStyle(
                                color: AppColor.greyDivider,
                                fontFamily: AppFont.regular),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty) {
                              return '* required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: stateController,
                    textInputAction: TextInputAction.next,
                    cursorColor: AppColor.appColor,
                    decoration: const InputDecoration(
                      labelText: 'State',
                      labelStyle: TextStyle(
                          color: AppColor.greyDivider,
                          fontFamily: AppFont.regular),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return '* required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: websiteController,
                    textInputAction: TextInputAction.done,
                    cursorColor: AppColor.appColor,
                    decoration: const InputDecoration(
                      labelText: 'Website',
                      labelStyle: TextStyle(
                          color: AppColor.greyDivider,
                          fontFamily: AppFont.regular),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<AddRestaurantProvider>(
                    builder: (context, snapshot,_) {
                      return Row(
                        children: [
                          snapshot.restaurantImageFile == null ?
                          InkWell(
                            onTap: (){
                              snapshot.selectBarberImage(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.4),
                              ),
                              width: MediaQuery.of(context).size.width/2.2,
                              height: 120,
                              child: const Center(child: Text("Select Image")),
                            ),
                          ) :
                          InkWell(
                            onTap: (){
                              snapshot.selectBarberImage(context);
                            },
                            child: Image.file(
                              snapshot.restaurantImageFile!,
                              height: 120,
                              width: MediaQuery.of(context).size.width/2.2,
                              fit: BoxFit.fill
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          FutureBuilder<LocationData?>(
                              future: CurrentLocation.instance.currentLocation(),
                              builder: (context, locationSnapshot) {
                                if(!locationSnapshot.hasData){
                                  return const CircularProgressIndicator();
                                }else {
                                  markers.add(Marker(
                                    markerId: const MarkerId("1"),
                                    onTap: (){},
                                    infoWindow: const InfoWindow(title: "You are here"),
                                    position: LatLng(locationSnapshot.data!.latitude!,locationSnapshot.data!.longitude!),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueRed,
                                    ),
                                  ));
                                  return Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                        height: 120,
                                        width: MediaQuery.of(context).size.width/2.2,
                                        child: GoogleMap(
                                          zoomControlsEnabled: false,
                                          onMapCreated: _onMapCreated,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(locationSnapshot.data!.latitude!,locationSnapshot.data!.longitude!),
                                            zoom: 11.0,
                                          ),
                                          markers: markers,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,left: 10,
                                        child: InkWell(
                                            child: Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.white),
                                                height: 40,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: const [
                                                    Icon(Icons.location_on,color: AppColor.appColor,),
                                                    SizedBox(width: 5),
                                                    Text("Select Location"),
                                                  ],
                                                )),
                                            onTap: ()=>
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                const AddLocationToMapScreen())).then((value) {
                                                  snapshot.latitude=value.latitude.toString();
                                                  snapshot.longitude=value.longitude.toString();
                                                })
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }
                          ),
                          /*InkWell(
                            onTap: (){

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.4)
                              ),
                              width: MediaQuery.of(context).size.width/2.2,
                              height: 120,
                              child: const Center(child: Text("Select Location")),
                            ),
                          )*/
                        ],
                      );
                    }
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: (){
                      // print("url ${Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads.toString()}");
                      // print("location ${Provider.of<AddRestaurantProvider>(context,listen: false).latitude}");
                      if(_formKey.currentState!.validate()){
                        if(Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads == null ||
                            Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads.toString().isEmpty){
                          showToast(
                            toastMessage: "Please select image"
                          );
                        }else{
                          if(Provider.of<AddRestaurantProvider>(context,listen: false).latitude == null ||
                              Provider.of<AddRestaurantProvider>(context,listen: false).longitude == null ||
                              Provider.of<AddRestaurantProvider>(context,listen: false).latitude.isEmpty ||
                              Provider.of<AddRestaurantProvider>(context,listen: false).longitude.isEmpty){
                            showToast(
                                toastMessage: "Please select Location"
                            );
                          }else{
                            Provider.of<AddRestaurantProvider>(context,listen: false).
                            insertALLRestaurant(
                                context,
                                restaurantNameController.text, foodController.text, phoneController.text, emailController.text,
                                areaController.text, cityController.text, stateController.text, websiteController.text,
                                Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads.toString(),
                                Provider.of<AddRestaurantProvider>(context,listen: false).latitude,
                                Provider.of<AddRestaurantProvider>(context,listen: false).longitude
                            );
                          }
                        }
                      }else{
                        print('else validation login screen');
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: AppColor.lightBlue
                          gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [Colors.green.shade400,Colors.green.shade600,Colors.green.shade700]
                          )
                      ),
                      child: const Center(
                          child: Text("Add Your Restaurant",
                            style: TextStyle(
                                color: AppColor.white,
                                fontFamily: AppFont.semiBold,
                                fontSize: 20
                            ),
                          )
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
