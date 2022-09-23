import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_font.dart';
import '../../../utils/mixin_textformfield.dart';
import '../../Add Restaurant/design/add_location_to_map_screen.dart';
import '../../Add Restaurant/provider/add_restaurant_provider.dart';
import '../../Add Restaurant/provider/current_location.dart';

class UpdateRestaurantDetails extends StatefulWidget {
  const UpdateRestaurantDetails({Key? key}) : super(key: key);

  @override
  State<UpdateRestaurantDetails> createState() => _UpdateRestaurantDetailsState();
}

class _UpdateRestaurantDetailsState extends State<UpdateRestaurantDetails> {

  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController foodController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final Set<Marker> markers = {};
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appColor.withOpacity(0.9),
          centerTitle: true,
          title: const Text('Edit Details'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFieldMixin().textFieldWidget(
                  labelText: 'Restaurant Name',
                  labelStyle: const TextStyle(color: AppColor.appColor),
                  // controller: restaurantNameController..text = data['fullName'],
                  controller: restaurantNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldMixin().textFieldWidget(
                  labelText: 'Food',
                  labelStyle: const TextStyle(color: AppColor.appColor),
                  // controller: restaurantNameController..text = data['fullName'],
                  controller: restaurantNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldMixin().textFieldWidget(
                  labelText: 'Phone no.',
                  labelStyle: const TextStyle(color: AppColor.appColor),
                  // controller: restaurantNameController..text = data['fullName'],
                  controller: restaurantNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldMixin().textFieldWidget(
                  labelText: 'Email ID',
                  labelStyle: const TextStyle(color: AppColor.appColor),
                  // controller: restaurantNameController..text = data['fullName'],
                  controller: restaurantNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldMixin().textFieldWidget(
                  labelText: 'Area',
                  labelStyle: const TextStyle(color: AppColor.appColor),
                  // controller: restaurantNameController..text = data['fullName'],
                  controller: restaurantNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldMixin().textFieldWidget(
                  labelText: 'City',
                  labelStyle: const TextStyle(color: AppColor.appColor),
                  // controller: restaurantNameController..text = data['fullName'],
                  controller: restaurantNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldMixin().textFieldWidget(
                  labelText: 'State',
                  labelStyle: const TextStyle(color: AppColor.appColor),
                  // controller: restaurantNameController..text = data['fullName'],
                  controller: restaurantNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldMixin().textFieldWidget(
                  labelText: 'Website',
                  labelStyle: const TextStyle(color: AppColor.appColor),
                  // controller: restaurantNameController..text = data['fullName'],
                  controller: restaurantNameController,
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
                          Image.file(
                              snapshot.restaurantImageFile!,
                              height: 120,
                              width: MediaQuery.of(context).size.height/3.9,
                              fit: BoxFit.fitWidth
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
                                        width: MediaQuery.of(context).size.height/3.9,
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
                Container(
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
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
