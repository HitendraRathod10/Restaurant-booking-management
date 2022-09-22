// import 'package:barber_booking_management/NearBy/current_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../provider/current_location.dart';

class AddLocationToMapScreen extends StatefulWidget {
  const AddLocationToMapScreen({Key? key}) : super(key: key);

  @override
  State<AddLocationToMapScreen> createState() => _AddLocationToMapScreenState();
}

class _AddLocationToMapScreenState extends State<AddLocationToMapScreen> {


  late GoogleMapController mapController;
  LocationData? currentLocation;
  final Set<Marker> markers = {};
  final markerController=TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<LocationData?>(
          future: CurrentLocation.instance.currentLocation(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }
            else{
              markers.add(Marker(
                markerId: const MarkerId("1"),
                onTap: (){},
                infoWindow: const InfoWindow(title: "You are here"),
                position: LatLng(snapshot.data!.latitude!,snapshot.data!.longitude!),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
              ));
              return Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(snapshot.data!.latitude!,snapshot.data!.longitude!),
                      zoom: 11.0,
                    ),
                    // onTap: (e){
                    //   Clipboard.setData(ClipboardData(text: "your text"));
                    // },
                    markers: markers,
                    onTap: (latLng){
                      _handleTap(LatLng(latLng.latitude, latLng.longitude)).then((value) {
                        debugPrint(value);
                        //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(latLng.latitude.toString())));
                        // const SnackBar(content: Text("hello",style: TextStyle(color: Colors.white))
                        //     ,backgroundColor: Colors.red);
                        Future.delayed(const Duration(milliseconds: 2000), () {
                          setState(() {
                            Navigator.pop(context,latLng);
                          });

                        });
                      });
                      //   users.doc().set({
                      //   "latitude":latLng.latitude.toString(),
                      //     "longitude":latLng.longitude.toString(),
                      //     "location":markerController.text,
                      //   "timeStamp":DateTime.now()
                      // }).then((value) => _handleTap(LatLng(latLng.latitude, latLng.longitude)));
                    },
                  ),
                ],
              );
            }
          }
      ),
    );
  }

  Future<String> _handleTap(LatLng point) async{
    String str="";
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: const InfoWindow(
          title: 'I am a marker',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
    });
    return str;
  }
}