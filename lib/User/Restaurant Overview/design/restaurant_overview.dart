import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/Add%20Restaurant/provider/add_restaurant_provider.dart';
import 'package:restaurant_booking_management/User/All%20Restaurant%20List/design/all_restaurants_screen.dart';
import 'package:restaurant_booking_management/User/Rating%20and%20Feedback/design/rating_and_feedback_screen_user.dart';
import 'package:restaurant_booking_management/User/Restaurant%20Overview/provider/restaurant_overview_provider.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';
import 'package:restaurant_booking_management/utils/app_image.dart';
import 'package:restaurant_booking_management/utils/mixin_toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/app_color.dart';
import '../../../utils/mixin_textformfield.dart';
import '../../Home/design/home_screen_user.dart';
import '../../Restaurant Book/design/restaurant_book.dart';

class RestaurantOverview extends StatefulWidget {
  DocumentSnapshot? doc;
  RestaurantOverview({required this.doc});
  // const RestaurantOverview({Key? key}) : super(key: key);

  @override
  State<RestaurantOverview> createState() => _RestaurantOverviewState();
}

class _RestaurantOverviewState extends State<RestaurantOverview> {
  final firebase = FirebaseFirestore.instance;
  TextEditingController reviewController = TextEditingController();
  bool phone = false;
  bool email = false;
  bool website = false;
  bool location = false;
  bool food = false;
  bool rating = false;
  double? ratingStar;
  String? fullName;
  var count;
  double userRating = 0;
  double ratingCount = 0;
  int userLength = 0;
  double sum = 0.0;
  List ratingList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone = true;
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  _launchURL() async {
    final url = '${widget.doc!.get("website")}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  _emailURl() async {
    String email = '${widget.doc!.get("email")}';
    String subject = '';
    String body = '';

    String emailUrl = "mailto:$email?subject=$subject&body=$body";
    if (await canLaunchUrl(Uri.parse(emailUrl))) {
    await launchUrl(Uri.parse(emailUrl));
    } else {
    throw "Error occured sending an email";
    }
  }

  static void navigateTo(String lat, String lng) async {
    // var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri);
    // } else {
    //   throw 'Could not launch ${uri.toString()}';
    // }
    final String googleMapsUrl = "comgooglemaps://?center=$lat,$lng";
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
    if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else {
      throw "Couldn't launch URL";
    }
  }

  /*  _mapURL() async {
    String? lat = "${widget.doc!.get("latitude")}";
    String? lng = "${widget.doc!.get("longitude")}";
    String mapUrl = "geo:$lat,$lng";
    if (await canLaunch(mapUrl)) {
    await launch(mapUrl);
    } else {
    throw "Couldn't launch Map";
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantBook(doc: widget.doc,)));
          },
          child: Container(
            height: 50,
            // width: 180,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                // color: AppColor.lightBlue
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Colors.green.shade400,Colors.green.shade600,Colors.green.shade700]
                )
            ),
            child: const Center(
                child: Text("Book now",
                  style: TextStyle(
                      color: AppColor.white,
                      fontFamily: AppFont.semiBold,
                      fontSize: 25
                  ),
                )
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/2.7,
                      width: double.infinity,
                      child: Image.network("${widget.doc!.get("image")}",fit: BoxFit.fill,)
                  ),
                  Positioned(
                    left: 10,
                      top: 10,
                      child: ClipOval(
                          child: InkWell(
                            onTap: (){
                              // Navigator.pop(context);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreenUser()));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColor.white
                              ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Icon(Icons.arrow_back_ios_rounded,size: 18,color: AppColor.black,),
                                )
                            ),
                          )
                      )
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 00, 00, 00),
                          child: Container(
                              // width: MediaQuery.of(context).size.width/1.5,
                            alignment: Alignment.centerLeft ,
                              child: Text("${widget.doc!.get("name")}",
                                style: const TextStyle(
                                    fontFamily: AppFont.semiBold,
                                    fontSize: 30
                                ),
                                // overflow: TextOverflow.ellipsis,
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 00, 00, 00),
                          child: Container(
                            // width: MediaQuery.of(context).size.width/1.5,
                              alignment: Alignment.centerLeft,
                              child: Text("${widget.doc!.get("area")}, ${widget.doc!.get("city")}, ${widget.doc!.get("state")}",
                                style: const TextStyle(
                                    fontFamily: AppFont.regular,
                                    fontSize: 15
                                ),
                                // overflow: TextOverflow.ellipsis,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RatingAndFeedbackScreen(name: widget.doc!.get("name"),)));
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.star,color: Colors.amber,size: 20),
                          const SizedBox(
                            width: 02,
                          ),
                          Container(
                            // color: Colors.redAccent,
                            // width: 35,
                            child: Text(widget.doc!.get("rating").toString().substring(0,3),
                              style: const TextStyle(
                                  fontFamily: AppFont.semiBold,
                                  fontSize: 20,
                                  color: AppColor.black
                              ),
                              // maxLines: 1,
                              // overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 00, 10, 00),
                child: Divider(
                  color: AppColor.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 00, 10, 00),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          phone = true;
                          email = false;
                          website = false;
                          location = false;
                          food = false;
                          rating = false;
                        });
                      },
                        child: const Icon(Icons.phone)
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          email = true;
                          phone = false;
                          website = false;
                          location = false;
                          food = false;
                          rating = false;
                        });
                      },
                        child: const Icon(Icons.email_outlined)
                    ),
                    InkWell(
                      onTap: (){
                          setState(() {
                            email = false;
                            phone = false;
                            website = true;
                            location = false;
                            food = false;
                            rating = false;
                          });
                      },
                        child: Image.asset(AppImage.website,width: 20)
                    ),
                    InkWell(
                      onTap: (){
                          setState(() {
                            email = false;
                            phone = false;
                            website = false;
                            location = true;
                            food = false;
                            rating = false;
                          });
                      },
                        child: const Icon(Icons.location_on_outlined)
                    ),
                    InkWell(
                      onTap: (){
                          setState(() {
                            email = false;
                            phone = false;
                            website = false;
                            location = false;
                            food = true;
                            rating = false;
                          });
                      },
                        child: Image.asset(AppImage.dishTwo,width: 20,)
                    ),
                    InkWell(
                      onTap: (){
                          setState(() {
                            email = false;
                            phone = false;
                            website = false;
                            location = false;
                            food = false;
                            rating = true;
                          });
                      },
                        child: const Icon(Icons.star_border)
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 00, 10, 00),
                child: Divider(
                  color: AppColor.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Phone
              phone == false ? const SizedBox.shrink() : InkWell(
                onTap: (){
                  _makePhoneCall(widget.doc!.get("phone"));
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  width: double.infinity,
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: const Icon(Icons.call,color: AppColor.black,)),
                        const SizedBox(width: 1,),
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: Text('${widget.doc!.get("phone")}',style: const TextStyle(fontFamily: AppFont.regular,fontSize: 20))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Email
              email == false ? const SizedBox.shrink() : InkWell(
                onTap: (){
                  _emailURl();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  width: double.infinity,
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: const Icon(Icons.email_outlined,color: AppColor.black,)),
                        const SizedBox(width: 1,),
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: Text('${widget.doc!.get("email")}',style: const TextStyle(fontFamily: AppFont.regular,fontSize: 20),)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Website
              website == false ? const SizedBox.shrink() : InkWell(
                onTap: (){
                  _launchURL();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  width: double.infinity,
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: Image.asset(AppImage.website,width: 20,)),
                        const SizedBox(width: 1,),
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: widget.doc!.get("website") == "" ?
                              const Text("Not Given",style: TextStyle(fontFamily: AppFont.regular,fontSize: 20),) :
                              Text('${widget.doc!.get("website")}',style: const TextStyle(fontFamily: AppFont.regular,fontSize: 20),)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Map
              location == false ? const SizedBox.shrink() : InkWell(
                onTap: (){
                  // _mapURL();
                  navigateTo(widget.doc!.get("latitude"),widget.doc!.get("longitude") );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  width: double.infinity,
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: const Icon(Icons.location_on_outlined)
                        ),
                        const SizedBox(width: 3,),
                        Expanded(
                          child: Text('${widget.doc!.get("area")}, ${widget.doc!.get("city")}, ${widget.doc!.get("state")}',
                            style: const TextStyle(fontFamily: AppFont.regular,fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Food
              food == false ? const SizedBox.shrink() : Container(
                margin: const EdgeInsets.only(left: 10,right: 10),
                width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Image.asset(AppImage.dishTwo,width: 20,
                          )
                      ),
                      const SizedBox(width: 3,),
                      Expanded(
                        child: Text('${widget.doc!.get("food")}',
                          style: const TextStyle(fontFamily: AppFont.regular,fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Rating
              rating == false ? const SizedBox.shrink() : RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 35,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  debugPrint('rating $rating');
                  setState(() {
                    userRating = 0;
                    ratingList.clear();
                    userRating = rating;
                    // ratingStar = rating;
                    // count = rating;
                    // userRating = 0;
                    // buttonVisible = true;
                    // ratingList.clear();
                    // userRating = rating;
                    // debugPrint('I am user Rating => $userRating');
                  });
                },
              ),
              rating == false ? const SizedBox.shrink() : const SizedBox(
                height: 10,
              ),
              rating == false ? const SizedBox.shrink() : Padding(
                padding: const EdgeInsets.fromLTRB(10, 00, 10, 00),
                child: TextFormField(
                  controller: reviewController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: "Feedback",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                  ),
                )
              ),
              rating == false ? const SizedBox.shrink() : const SizedBox(
                height: 20,
              ),
              rating == false ? const SizedBox.shrink() : InkWell(
                onTap: () async {
                  //add rating
                  ratingList.clear();
                  /*var querySnapShot = await firebase.collection("User").
                  where('userEmail',isEqualTo: FirebaseAuth.instance.currentUser?.email).get();

                  var queryUserRatingSnapshots = await firebase.collection("Rating").
                  where('restaurantName',isEqualTo: widget.doc!.get("name"));

                  var queryRestaurantSnapshots = await firebase.collection("All Restaurants").
                  where('shopName',isEqualTo: widget.doc!.get("name"));

                  for (var snapshot in querySnapShot.docChanges) {
                    RatingAuth().userRating(
                      shopName: widget.snapshotData['shopName'],
                      barberName: widget.snapshotData['barberName'],
                      currentUser: FirebaseAuth.instance.currentUser!.email.toString(),
                      currentDate: DateTime.now().toString().substring(0,10),
                      userRating: userRating,
                      userExprience: reviewController.text,
                      timestamp: Timestamp.now(),
                      userName: snapshot.doc.get('userName'),
                      userImage: snapshot.doc.get('userImage'),
                    ).then((value) {
                      for (var snapshot in queryUserRatingSnapshots.docChanges) {
                        for(int i = 0;i<1;i++){
                          userRating = snapshot.doc.get('shopRating');
                          ratingList.add(snapshot.doc.get('shopRating'));
                          sum = ratingList.reduce((a, b) => a + b);
                          userLength = queryUserRatingSnapshots.docs.length;
                          rating = sum/userLength;
                          debugPrint('User Rating => $sum = $userLength = $rating = $userRating');
                          break;
                        }
                      }

                      for(var shopSnapshot in queryShopSnapshots.docChanges){
                        uId = snapshot.doc.get('uid');
                        userName = snapshot.doc.get('userName');
                        shopName = shopSnapshot.doc.get('shopName');
                        shopDescription = shopSnapshot.doc.get('shopDescription');
                        status = shopSnapshot.doc.get('shopStatus');
                        openingHour= shopSnapshot.doc.get('openingHour');
                        closingHour= shopSnapshot.doc.get('closingHour');
                        shopEmail= shopSnapshot.doc.get('shopEmail');
                        barberName= shopSnapshot.doc.get('barberName');
                        hairCategory= shopSnapshot.doc.get('hairCategory');
                        price= shopSnapshot.doc.get('price');
                        longitudeShop= shopSnapshot.doc.get('longitude');
                        latitudeShop= shopSnapshot.doc.get('latitude');
                        gender= shopSnapshot.doc.get('gender');
                        contactNumber= shopSnapshot.doc.get('contactNumber');
                        timestamp= shopSnapshot.doc.get('timeStamp');
                        address = shopSnapshot.doc.get('address');
                        coverPageImage = shopSnapshot.doc.get('coverPageImage');
                        barberImage = shopSnapshot.doc.get('barberImage');
                        shopImage = shopSnapshot.doc.get('shopImage');
                        currentUser = shopSnapshot.doc.get('currentUser');
                        webSiteUrl= shopSnapshot.doc.get('webSiteUrl');
                      }
                      AddShopDetailFirebase().addShopDetail(
                          userName: userName,uId: uId,
                          shopName: shopName, shopDescription: shopDescription,
                          rating: rating, status: status,
                          openingHour: openingHour, closingHour: closingHour,
                          shopEmail: shopEmail,
                          barberName: barberName,
                          currentUser: currentUser,
                          hairCategory: hairCategory, price: price,
                          longitudeShop: longitudeShop, latitudeShop: latitudeShop,
                          contactNumber: contactNumber, webSiteUrl: webSiteUrl,
                          gender: gender,
                          address: address, coverPageImage: coverPageImage,
                          barberImage: barberImage, shopImage: shopImage,
                          timestamp: timestamp);
                      Navigator.pop(context);
                    });
                  }*/
                  var dataName = await firebase.collection('User').get();
                  for(var i in dataName.docChanges){
                    if(i.doc.get('email') == FirebaseAuth.instance.currentUser!.email){
                      fullName = i.doc.get('fullName');
                      break;
                    }
                  }
                  Provider.of<RestaurantOverviewProvider>(context,listen: false).
                  addRating(
                      "${FirebaseAuth.instance.currentUser!.email}",
                      "$fullName",
                      userRating,
                      "${widget.doc!.get("name")}",
                      reviewController.text);
                  //count
                  var queryUserRatingSnapshots = await FirebaseFirestore.instance.collection("Rating").
                  where('restaurantName',isEqualTo: widget.doc!.get("name")).get();
                  for (var snapshot in queryUserRatingSnapshots.docChanges) {
                    for (int i = 0; i < 1; i++) {
                      userRating = snapshot.doc.get('rating');
                      ratingList.add(snapshot.doc.get('rating'));
                      sum = ratingList.reduce((a, b) => a + b);
                      userLength = queryUserRatingSnapshots.docs.length;
                      ratingCount = sum / userLength;
                      debugPrint('User Rating => $sum = $userLength = $ratingCount = $userRating');
                      break;
                    }
                  }
                  //all restaurant
                  Provider.of<AddRestaurantProvider>(context,listen: false).
                  insertALLRestaurant(
                    context,
                    "${widget.doc!.get("shopOwnerEmail")}",
                    "${widget.doc!.get("name")}",
                    "${widget.doc!.get("food")}",
                    "${widget.doc!.get("phone")}",
                    "${widget.doc!.get("email")}",
                    "${widget.doc!.get("area")}",
                    "${widget.doc!.get("city")}",
                    "${widget.doc!.get("state")}",
                    "${widget.doc!.get("website")}",
                    "${widget.doc!.get("image")}",
                    "${widget.doc!.get("latitude")}",
                    "${widget.doc!.get("longitude")}",
                    ratingCount
                  );
                  await FirebaseFirestore.instance.
                  collection("User").
                  doc(widget.doc!.get("shopOwnerEmail")).
                  collection('My Restaurants').
                  doc(widget.doc!.get("name")).
                  set({
                    "userEmail" : widget.doc!.get("shopOwnerEmail"),
                    "name" : widget.doc!.get("name"),
                    "food" : widget.doc!.get("food"),
                    "phone" : widget.doc!.get("phone"),
                    "email" : widget.doc!.get("email"),
                    "area" : widget.doc!.get("area"),
                    "city" : widget.doc!.get("city"),
                    "state" : widget.doc!.get("state"),
                    "website" : widget.doc!.get("website"),
                    "image" : widget.doc!.get("image"),
                    "latitude" : widget.doc!.get("latitude"),
                    "longitude" : widget.doc!.get("longitude"),
                    "rating" : ratingCount
                  });
                  showToast(toastMessage: "Your review posted successfully.");
                  reviewController.clear();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: 160,
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
                      child: Text("Post",
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
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
