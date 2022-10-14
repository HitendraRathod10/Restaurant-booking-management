import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    markerLocation();
    // FirebaseCollection().shopCollection.get().then((value) {
    // firebase.collection('All Restaurants').get().then((value) {
    //   for(int i=0;i<value.docs.length;i++){
    //     markers.add(Marker(markerId: MarkerId(value.docs[i].id),
    //         infoWindow:  InfoWindow(title: value.docs[i]['name']),
    //         position: LatLng(double.parse(value.docs[i]["latitude"]),double.parse(value.docs[i]["longitude"])),
    //         icon: BitmapDescriptor.defaultMarkerWithHue(
    //           BitmapDescriptor.hueRed,
    //         )),
    //     );
    //   }
    // });
  }

  Future markerLocation() async{
    var shopQuerySnapshot = await FirebaseFirestore.instance.collection("All Restaurants").get();
    for(var snapShot in shopQuerySnapshot.docChanges){
      markers.add(Marker(
          markerId: MarkerId(snapShot.doc.get('name')),
          onTap: (){
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Wrap(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10,10,10,20),
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.white
                      ),
                      child:  Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(snapShot.doc.get('image'),
                                height: 90,width: 90,fit: BoxFit.fill),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  const SizedBox(height: 2),
                                  Text(snapShot.doc.get('name'),
                                      style : const TextStyle(color: AppColor.appColor,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: AppFont.semiBold),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  const SizedBox(height: 2),
                                  Text("${snapShot.doc.get('area')} ${snapShot.doc.get('city')}",
                                      style : const TextStyle(fontSize: 16,fontFamily: AppFont.semiBold),maxLines: 1,overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 4),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      RatingBar.builder(
                                        initialRating: 5,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        ignoreGestures : true,
                                        itemSize: 18,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          debugPrint('$rating');
                                        },
                                      ),
                                      const SizedBox(width: 5,),
                                      Text('(${snapShot.doc.get('rating').toString().substring(0,3)} review)',
                                          style:  const TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: AppFont.semiBold),
                                          maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          },
          position: LatLng(double.parse(snapShot.doc.get('latitude')),double.parse(snapShot.doc.get('longitude'))),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          )));
    }
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
            title: const Text("Restaurants Near Me",style: TextStyle(fontFamily: AppFont.semiBold)),
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
