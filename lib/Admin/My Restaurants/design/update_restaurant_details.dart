import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/Add%20Restaurant/provider/add_restaurant_provider.dart';
import 'package:restaurant_booking_management/Admin/My%20Restaurants/provider/update_restaurant_details_provider.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_font.dart';
import '../../../utils/mixin_textformfield.dart';
import '../../../utils/mixin_toast.dart';
import '../../Add Restaurant/design/add_location_to_map_screen.dart';
import '../../Add Restaurant/provider/current_location.dart';

class UpdateRestaurantDetails extends StatefulWidget {
  String? id;
  UpdateRestaurantDetails({required this.id});
  // const UpdateRestaurantDetails({Key? key}) : super(key: key);

  @override
  State<UpdateRestaurantDetails> createState() => _UpdateRestaurantDetailsState();
}

class _UpdateRestaurantDetailsState extends State<UpdateRestaurantDetails> {


  final Set<Marker> markers = {};
  late GoogleMapController mapController;
  String? latitudeDouble;
  String? longitudeDouble;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UpdateRestaurantDetailsProvider>(context, listen: false).getData(widget.id!);
    latitudeDouble = Provider.of<UpdateRestaurantDetailsProvider>(context, listen: false).latitude;
    longitudeDouble = Provider.of<UpdateRestaurantDetailsProvider>(context, listen: false).longitude;
    // print("init lat long ${double.parse(latitudeDouble!)} ${double.parse(longitudeDouble!)}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appColor.withOpacity(0.9),
          centerTitle: true,
          title: const Text('Edit Details',
            style: TextStyle(
              fontFamily: AppFont.semiBold
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(10),
              child: Consumer<UpdateRestaurantDetailsProvider>(
                builder: (context, snapshot,_) {
                  return Column(
                    children: [
                      TextFieldMixin().textFieldWidget(
                        textStyle: const TextStyle(fontFamily: AppFont.regular),
                        labelText: 'Restaurant Name',
                        labelStyle: const TextStyle(color: AppColor.appColor),
                        // controller: restaurantNameController..text = data['fullName'],
                        controller: snapshot.restaurantNameController,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return '* required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldMixin().textFieldWidget(
                        textStyle: const TextStyle(fontFamily: AppFont.regular),
                        labelText: 'Food',
                        labelStyle: const TextStyle(color: AppColor.appColor),
                        // controller: restaurantNameController..text = data['fullName'],
                        controller: snapshot.foodController,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return '* required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldMixin().textFieldWidget(
                        textStyle: const TextStyle(fontFamily: AppFont.regular),
                        labelText: 'Phone no.',
                        labelStyle: const TextStyle(color: AppColor.appColor),
                        // controller: restaurantNameController..text = data['fullName'],
                        controller: snapshot.phoneController,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return '* required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldMixin().textFieldWidget(
                        textStyle: const TextStyle(fontFamily: AppFont.regular),
                        labelText: 'Email ID',
                        labelStyle: const TextStyle(color: AppColor.appColor),
                        // controller: restaurantNameController..text = data['fullName'],
                        controller: snapshot.emailController,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return '* required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldMixin().textFieldWidget(
                        textStyle: const TextStyle(fontFamily: AppFont.regular),
                        labelText: 'Area',
                        labelStyle: const TextStyle(color: AppColor.appColor),
                        // controller: restaurantNameController..text = data['fullName'],
                        controller: snapshot.areaController,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return '* required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldMixin().textFieldWidget(
                        textStyle: const TextStyle(fontFamily: AppFont.regular),
                        labelText: 'City',
                        labelStyle: const TextStyle(color: AppColor.appColor),
                        // controller: restaurantNameController..text = data['fullName'],
                        controller: snapshot.cityController,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return '* required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldMixin().textFieldWidget(
                        textStyle: const TextStyle(fontFamily: AppFont.regular),
                        labelText: 'State',
                        labelStyle: const TextStyle(color: AppColor.appColor),
                        // controller: restaurantNameController..text = data['fullName'],
                        controller: snapshot.stateController,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return '* required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldMixin().textFieldWidget(
                        textStyle: const TextStyle(fontFamily: AppFont.regular),
                        labelText: 'Website',
                        labelStyle: const TextStyle(color: AppColor.appColor),
                        // controller: restaurantNameController..text = data['fullName'],
                        controller: snapshot.websiteController,
                        maxLines: 5
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<UpdateRestaurantDetailsProvider>(
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
                                    child: Image.network("${snapshot.image}",fit: BoxFit.fill),
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
                                      fit: BoxFit.fitWidth
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
                                                  target: LatLng(double.parse(Provider.of<UpdateRestaurantDetailsProvider>(context, listen: false).latitude.toString()),
                                                      double.parse(Provider.of<UpdateRestaurantDetailsProvider>(context, listen: false).latitude.toString())),
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
                                                          Text("Select Location",
                                                            style: TextStyle(
                                                              fontFamily: AppFont.regular
                                                            ),
                                                          ),
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
                          if(_formKey.currentState!.validate()){
                            var data = Provider.of<UpdateRestaurantDetailsProvider>(context,listen: false);
                            Provider.of<UpdateRestaurantDetailsProvider>(context,listen: false).
                            updateInALLRestaurant(context,
                                data.restaurantNameController.text,
                                data.foodController.text,
                                data.phoneController.text,
                                data.emailController.text,
                                data.areaController.text,
                                data.cityController.text,
                                data.stateController.text,
                                data.websiteController.text,
                                Provider.of<UpdateRestaurantDetailsProvider>(context,listen: false).restaurantImageFile == "" ||
                                    Provider.of<UpdateRestaurantDetailsProvider>(context,listen: false).restaurantImageFile == null ?
                                Provider.of<UpdateRestaurantDetailsProvider>(context,listen: false).image.toString() :
                                Provider.of<UpdateRestaurantDetailsProvider>(context,listen: false).urlDownloads.toString() ,
                                data.latitude.toString(),
                                data.longitude.toString(),
                                widget.id!
                            );
                          }else{
                            print("validation in update restaurant details screen");
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 220,
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
                              child: Text("Update Restaurant Details",
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
                        height: 20,
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
