import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/User/Restaurant%20Overview/provider/restaurant_overview_provider.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';
import 'package:restaurant_booking_management/utils/app_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/app_color.dart';
import '../../../utils/mixin_textformfield.dart';
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
  var ratingStar;
  String? fullName;
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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _emailURl() async {
    String email = '${widget.doc!.get("email")}';
    String subject = '';
    String body = '';

    String emailUrl = "mailto:$email?subject=$subject&body=$body";
    if (await canLaunch(emailUrl)) {
    await launch(emailUrl);
    } else {
    throw "Error occured sending an email";
    }
  }

  static void navigateTo(String lat, String lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
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
                              Navigator.pop(context);
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
                    child: Row(
                      children: [
                        const Icon(Icons.star,color: Colors.amber,size: 20),
                        const SizedBox(
                          width: 02,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(00, 00, 10, 00),
                          child: Text("${widget.doc!.get("rating")}",style: TextStyle(fontFamily: AppFont.semiBold,fontSize: 20,color: AppColor.black),),
                        ),
                      ],
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
                    ratingStar = rating;
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
                  var dataName = await firebase.collection('User').get();
                  for(var i in dataName.docChanges){
                    if(i.doc.get('email') == FirebaseAuth.instance.currentUser!.email){
                      fullName = i.doc.get('fullName');
                      break;
                    }
                  }
                  print("userEmail ${FirebaseAuth.instance.currentUser!.email}");
                  print("userName $fullName");
                  print("rating $ratingStar");
                  print("restaurantName ${widget.doc!.get("name")}");
                  print("feedback ${reviewController.text}");
                  Provider.of<RestaurantOverviewProvider>(context,listen: false).
                  addRating(
                      "${FirebaseAuth.instance.currentUser!.email}",
                      "$fullName",
                      "$ratingStar",
                      "${widget.doc!.get("name")}",
                      // "restaurantOwnerName",
                      reviewController.text
                  );
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
