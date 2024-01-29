import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/Add%20Restaurant/provider/add_restaurant_provider.dart';
import 'package:restaurant_booking_management/utils/app_color.dart';
import '../../../utils/app_font.dart';
import '../../../utils/mixin_toast.dart';
import '../../Home/design/home_screen_admin.dart';
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
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Provider.of<AddRestaurantProvider>(context,listen: false).restaurantImageFile = null;
        Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads = "";
        Provider.of<AddRestaurantProvider>(context,listen: false).latitude = "";
        Provider.of<AddRestaurantProvider>(context,listen: false).longitude= "";
        Provider.of<AddRestaurantProvider>(context,listen: false).isLoading= false;
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Add Restaurant",style: TextStyle(fontFamily: AppFont.regular),),
            backgroundColor: AppColor.appColor.withOpacity(0.9),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Provider.of<AddRestaurantProvider>(context,listen: false).restaurantImageFile = null;
                Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads = "";
                Provider.of<AddRestaurantProvider>(context,listen: false).latitude = "";
                Provider.of<AddRestaurantProvider>(context,listen: false).longitude= "";
                Provider.of<AddRestaurantProvider>(context,listen: false).isLoading= false;
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 00),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.always,

                child: Column(
                  children: [
                    TextFormField(
                      controller: restaurantNameController,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.appColor,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                          fontFamily: AppFont.regular
                      ),

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50)
                      ],
                      decoration: const InputDecoration(
                        hintText:  'Restaurant Name*',
                        hintStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty ||
                            value.trim().isEmpty) {
                          return 'Please enter a restaurant name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: foodController,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.appColor,
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      style: const TextStyle(
                          fontFamily: AppFont.regular
                      ),

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50)
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Food*',
                        hintStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return 'Please enter a food';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: phoneController,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.appColor,
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      style: const TextStyle(
                          fontFamily: AppFont.regular
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Phone number*',
                        hintStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular
                        ),
                      ),

                      validator: (value) {
                        if (value!.trim().isEmpty || value.length != 10 ) {
                          return 'Please enter a 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColor.appColor,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                        fontFamily: AppFont.regular,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Email ID*',
                        hintStyle: TextStyle(
                          color: AppColor.greyDivider,
                          fontFamily: AppFont.regular,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.trim().isEmpty) {
                          return 'Please enter email address';
                        } else if (value.contains(RegExp(r'[A-Z]'))) {
                          return 'Please enter email in small letters';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email address';
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,

                            style: const TextStyle(
                                fontFamily: AppFont.regular
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Area*',
                              hintStyle: TextStyle(
                                  color: AppColor.greyDivider,
                                  fontFamily: AppFont.regular),
                            ),

                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().isEmpty) {
                                return 'Please enter an area';
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,

                            style: const TextStyle(
                                fontFamily: AppFont.regular
                            ),
                            decoration: const InputDecoration(
                              hintText: 'City*',
                              hintStyle: TextStyle(
                                  color: AppColor.greyDivider,
                                  fontFamily: AppFont.regular),
                            ),

                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().isEmpty) {
                                return 'Please enter a city';
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                          fontFamily: AppFont.regular
                      ),
                      decoration: const InputDecoration(
                        hintText: 'State*',
                        hintStyle: TextStyle(
                            color: AppColor.greyDivider,
                            fontFamily: AppFont.regular),
                      ),

                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return 'Please enter the state';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: websiteController,
                      textInputAction: TextInputAction.done,
                      cursorColor: AppColor.appColor,
                      style: const TextStyle(
                          fontFamily: AppFont.regular
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Website',
                        hintStyle: TextStyle(
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
                                FocusScope.of(context).unfocus();
                                snapshot.selectBarberImage(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                                width: MediaQuery.of(context).size.width/2.2,
                                height: 120,
                                child:  Center(child: snapshot.isLoading? const CircularProgressIndicator(
                                  color: AppColor.appColor,
                                ) :const Text("Select Image",style: TextStyle(fontFamily: AppFont.semiBold),)),
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
                                    return const CircularProgressIndicator(
                                      color: AppColor.appColor,
                                    );
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
                                                      Text("Select Location",style: TextStyle(fontFamily: AppFont.semiBold),),
                                                    ],
                                                  )),
                                              onTap: (){
                                                FocusScope.of(context).unfocus();
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                  const AddLocationToMapScreen())).then((value) {
                                                    snapshot.latitude=value.latitude.toString();
                                                    snapshot.longitude=value.longitude.toString();
                                                  });}
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
                        // debugPrint("url ${Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads.toString()}");
                        // debugPrint("location ${Provider.of<AddRestaurantProvider>(context,listen: false).latitude}");
                        if(_formKey.currentState!.validate()){
                          if(Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads == null ||
                              Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads.toString().isEmpty){
                            showToast(
                              toastMessage: "Please select image"
                            );
                          }else{
                            if(Provider.of<AddRestaurantProvider>(context,listen: false).latitude == '' ||
                                Provider.of<AddRestaurantProvider>(context,listen: false).longitude == '' ||
                                Provider.of<AddRestaurantProvider>(context,listen: false).latitude.isEmpty ||
                                Provider.of<AddRestaurantProvider>(context,listen: false).longitude.isEmpty){
                              showToast(
                                  toastMessage: "Please select Location"
                              );
                            }else{
                              Provider.of<AddRestaurantProvider>(context,listen: false).
                              insertALLRestaurant(
                                  context,
                                  FirebaseAuth.instance.currentUser!.email.toString(),
                                  restaurantNameController.text,
                                  foodController.text,
                                  phoneController.text,
                                  emailController.text,
                                  areaController.text,
                                  cityController.text,
                                  stateController.text,
                                  websiteController.text,
                                  Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads.toString(),
                                  Provider.of<AddRestaurantProvider>(context,listen: false).latitude,
                                  Provider.of<AddRestaurantProvider>(context,listen: false).longitude,
                                  0.1
                                  // context,
                                  // FirebaseAuth.instance.currentUser!.email.toString(),
                                  // restaurantNameController.text, foodController.text, phoneController.text, emailController.text,
                                  // areaController.text, cityController.text, stateController.text, websiteController.text,
                                  // Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads.toString(),
                                  // Provider.of<AddRestaurantProvider>(context,listen: false).latitude,
                                  // Provider.of<AddRestaurantProvider>(context,listen: false).longitude,
                                  // 0.1
                              );
                              Provider.of<AddRestaurantProvider>(context,listen: false).
                              insertMyRestaurant(
                                  FirebaseAuth.instance.currentUser!.email.toString(),
                                  restaurantNameController.text,
                                  foodController.text,
                                  phoneController.text,
                                  emailController.text,
                                  areaController.text,
                                  cityController.text,
                                  stateController.text,
                                  websiteController.text,
                                  Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads.toString(),
                                  Provider.of<AddRestaurantProvider>(context,listen: false).latitude,
                                  Provider.of<AddRestaurantProvider>(context,listen: false).longitude,
                                  0.1
                              );

                              showToast(
                                  toastMessage: "Restaurant added successfully"
                              );
                              Provider.of<AddRestaurantProvider>(context,listen: false).urlDownloads = "";
                              Provider.of<AddRestaurantProvider>(context,listen: false).latitude = "";
                              Provider.of<AddRestaurantProvider>(context,listen: false).restaurantImageFile = null;
                              Provider.of<AddRestaurantProvider>(context,listen: false).longitude= "";
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenAdmin()));
                              Provider.of<AddRestaurantProvider>(context,listen: false).restaurantImageFile = null;
                            }
                          }
                        }else{
                          debugPrint('else validation login screen');
                        }
                      },
                      child: Container(
                        // height: 50,
                        // width: 180,
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
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(00, 10, 00, 10),
                              child: Text("Add Restaurant",
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontFamily: AppFont.semiBold,
                                    fontSize: 20
                                ),
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
      ),
    );
  }
}
