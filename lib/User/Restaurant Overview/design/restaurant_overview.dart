import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';
import 'package:restaurant_booking_management/utils/app_image.dart';

import '../../../utils/app_color.dart';
import '../../../utils/mixin_textformfield.dart';
import '../../Restaurant Book/design/restaurant_book.dart';

class RestaurantOverview extends StatefulWidget {
  const RestaurantOverview({Key? key}) : super(key: key);

  @override
  State<RestaurantOverview> createState() => _RestaurantOverviewState();
}

class _RestaurantOverviewState extends State<RestaurantOverview> {

  TextEditingController reviewController = TextEditingController();
  bool phone = false;
  bool email = false;
  bool website = false;
  bool location = false;
  bool food = false;
  bool rating = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantBook()));
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
                      fontSize: 20
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
                  Image.asset(AppImage.rest1),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 00, 00, 00),
                        child: Container(
                          alignment: Alignment.centerLeft ,
                            child: const Text("Kshitij Restaurant",
                              style: TextStyle(
                                  fontFamily: AppFont.bold,
                                  fontSize: 30
                              ),
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 00, 00, 00),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("New Ranip, Ahmedabad, Gujarat",
                              style: TextStyle(
                                  fontFamily: AppFont.medium,
                                  fontSize: 15
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.star,color: Colors.amber,size: 20),
                  const SizedBox(
                    width: 02,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(00, 00, 10, 00),
                    child: Text("5.0",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20,color: AppColor.black),),
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
                        child: Icon(Icons.star_border)
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
              phone == false ? SizedBox.shrink() : Container(
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
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Text('9898989898',style: TextStyle(fontFamily: AppFont.regular,fontSize: 20),)),
                    ],
                  ),
                ),
              ),
              //Email
              email == false ? SizedBox.shrink() : Container(
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
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Text('kshitij.newranip@gmail.com',style: TextStyle(fontFamily: AppFont.regular,fontSize: 20),)),
                    ],
                  ),
                ),
              ),
              //Website
              website == false ? SizedBox.shrink() : Container(
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
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Text('http://www.kshitijrestaurant.co.in/',style: TextStyle(fontFamily: AppFont.regular,fontSize: 20),)),
                    ],
                  ),
                ),
              ),
              //Map
              location == false ? SizedBox.shrink() : Container(
                margin: const EdgeInsets.only(left: 10,right: 10),
                width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Icon(Icons.location_on_outlined)
                      ),
                      const SizedBox(width: 3,),
                      const Expanded(
                        child: Text('New Ranip Ahmedabad Gujarat',
                          style: TextStyle(fontFamily: AppFont.regular,fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Food
              food == false ? SizedBox.shrink() : Container(
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
                      const Expanded(
                        child: Text('Punjabi Kathiyavadi Chinese Italian Mexican Punjabi Kathiyavadi '
                            'Chinese Italian Mexican Punjabi Kathiyavadi Chinese Italian Mexican Punjabi '
                            'Kathiyavadi Chinese Italian Mexican Punjabi Kathiyavadi '
                            'Chinese Italian Mexican Punjabi Kathiyavadi Chinese Italian Mexican',
                          style: TextStyle(fontFamily: AppFont.regular,fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Rating
              rating == false ? SizedBox.shrink() : RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 30,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  debugPrint('rating $rating');
                  setState(() {
                    // userRating = 0;
                    // buttonVisible = true;
                    // ratingList.clear();
                    // userRating = rating;
                    // debugPrint('I am user Rating => $userRating');
                  });
                },
              ),
              rating == false ? SizedBox.shrink() : SizedBox(
                height: 10,
              ),
              rating == false ? SizedBox.shrink() : Padding(
                padding: const EdgeInsets.fromLTRB(10, 00, 10, 00),
                child: TextFieldMixin().textFieldWidget(
                  hintText: 'Feedback',
                  labelStyle: const TextStyle(color: AppColor.appColor),
                  controller: reviewController,
                  maxLines: 3,
                ),
              ),
              rating == false ? SizedBox.shrink() : SizedBox(
                height: 20,
              ),
              rating == false ? SizedBox.shrink() : Container(
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
                    child: Text("Give feedback",
                      style: TextStyle(
                          color: AppColor.white,
                          fontFamily: AppFont.semiBold,
                          fontSize: 20
                      ),
                    )
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
