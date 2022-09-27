import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';

import '../../../Admin/Add Restaurant/provider/current_location.dart';
import '../../../utils/app_color.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  final firebase = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // FirebaseCollection().shopCollection.get().then((value) {
    firebase.collection('All Restaurants').get().then((value) {
      for(int i=0;i<value.docs.length;i++){
        markers.add(Marker(markerId: MarkerId(value.docs[i].id),
            infoWindow:  InfoWindow(title: value.docs[i]['name']),
            position: LatLng(double.parse(value.docs[i]["latitude"]),double.parse(value.docs[i]["longitude"])),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            )),
        );
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text("Map Screen",style: TextStyle(fontFamily: AppFont.semiBold)),
            backgroundColor: AppColor.appColor.withOpacity(0.9),
          ),
          body: FutureBuilder<LocationData?>(
              future: CurrentLocation.instance.currentLocation(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator());
                }else{
                  markers.add(Marker(
                    markerId: const MarkerId("1"),
                    onTap: (){},
                    infoWindow: const InfoWindow(title: "You are here"),
                    position: LatLng(snapshot.data!.latitude!,snapshot.data!.longitude!),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure,
                    ),
                  ));
                  return GoogleMap(
                    zoomGesturesEnabled: true,
                    myLocationEnabled : true,
                    compassEnabled: true,
                    mapToolbarEnabled: true,
                    tiltGesturesEnabled: true,
                    myLocationButtonEnabled: true,
                    indoorViewEnabled: true,
                    // trafficEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(snapshot.data!.latitude!,snapshot.data!.longitude!),
                      zoom: 11.0,
                    ),
                    markers: markers,
                    onTap: (latLng){},
                  );
                }
              }
          ),
        )
    );
  }
}
