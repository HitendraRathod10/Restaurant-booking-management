import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/User/Restaurant%20Book/provider/restaurant_book_provider.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';
import 'package:time_range/time_range.dart';


import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';

class RestaurantBook extends StatefulWidget {
  DocumentSnapshot? doc;
  RestaurantBook({required this.doc});
  // const RestaurantBook({Key? key}) : super(key: key);

  @override
  State<RestaurantBook> createState() => _RestaurantBookState();
}

class _RestaurantBookState extends State<RestaurantBook> {

  final currentDate = DateTime.now();
  final dayFormatter = DateFormat('dd');
  final monthFormatter = DateFormat('MMM');
  List dates = [];
  DateTime? date;
  // bool isSelected = false;
  int? selectedIndex;
  int? selectedIndexDate;
  int? personSend;
  String? dateSend;
  String? timeSend;
  final firebase = FirebaseFirestore.instance;
  String? fullName;
  methodForDate(){
    for (int i = 0; i < 5; i++) {
      date = currentDate.add(Duration(days: i));
      // print("date ${date}");
      setState(() {
        dates.add(date);
      });
      // print("datee ${dayFormatter.format(date!)}");
      // dates.add(Column(
      //   children: [
      //     Text(dayFormatter.format(date)),
      //     Text(monthFormatter.format(date)),
      //   ],
      // ));
    }
    // print(dates);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    methodForDate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/4,
                    width: double.infinity,
                    child: Image.asset(
                        AppImage.rest1,
                      fit: BoxFit.cover,
                    ),
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
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 00, 10, 00),
                child: Container(
                  alignment: Alignment.centerLeft,
                    child: const Text("T A B L E   B O O K I N G",
                    style: TextStyle(fontFamily: AppFont.semiBold,fontSize: 20),
                    )
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 00, 10, 00),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Booking for",
                      style: TextStyle(
                          fontFamily: AppFont.semiBold,
                          fontSize: 20
                      ),
                    )
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //Booking for person code
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 10,
                        padding: const EdgeInsets.fromLTRB(17, 00, 00, 00),
                        itemBuilder: (context,index){
                          return Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    selectedIndex=index;
                                  });
                                  print("Person : ${index+1} Person");
                                  personSend = index+1;
                                },
                                child: Container(
                                  height: 40,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selectedIndex==index ? AppColor.appColor : AppColor.greyDivider.withOpacity(0.2)
                                  ),
                                  child: Center(child: Text("${index+1} Person",style: const TextStyle(fontFamily: AppFont.regular,fontSize: 15),)),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              /*Container(
                                height: 40,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.greyDivider.withOpacity(0.2)
                                ),
                                child: const Center(child: Text("10+ Person")),
                              ),
                              const SizedBox(
                                width: 15,
                              )*/
                            ],
                          );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 00, 10, 00),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Select Date",
                      style: TextStyle(
                          fontFamily: AppFont.semiBold,
                          fontSize: 20
                      ),
                    )
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //Date code
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 5,
                          padding: const EdgeInsets.fromLTRB(17, 00, 00, 00),
                          itemBuilder: (context,index){
                            return Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      selectedIndexDate=index;
                                    });
                                    dateSend = "${dayFormatter.format(dates[index])} ${monthFormatter.format(dates[index])}";
                                    print("dateSend in ontap of date ${dateSend}");
                                    print("Date : ${dayFormatter.format(dates[index])} ${monthFormatter.format(dates[index])}");
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: selectedIndexDate==index ? AppColor.appColor : AppColor.greyDivider.withOpacity(0.2)
                                    ),
                                    child: Center(
                                      // child: methodForDate(),
                                        child: Text("${dayFormatter.format(dates[index])} ${monthFormatter.format(dates[index])}",
                                          style: const TextStyle(
                                              fontFamily: AppFont.regular,
                                              fontSize: 15
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 00, 10, 00),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Select Time",
                      style: TextStyle(
                          fontFamily: AppFont.semiBold,
                          fontSize: 20
                      ),
                    )
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TimeRange(
                fromTitle: const Text('From', style: TextStyle(fontSize: 18, color: AppColor.black),),
                toTitle: const Text('To', style: TextStyle(fontSize: 18, color: AppColor.black),),
                titlePadding: 20,
                textStyle: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
                activeTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                borderColor: AppColor.greyDivider.withOpacity(0.2),
                backgroundColor: AppColor.greyDivider.withOpacity(0.2),
                activeBackgroundColor: AppColor.appColor,
                activeBorderColor: AppColor.appColor,
                firstTime: const TimeOfDay(hour: 11, minute: 00),
                lastTime: const TimeOfDay(hour: 24, minute: 00),
                timeStep: 15,
                timeBlock: 60,
                onRangeCompleted: (range) {
                  timeSend = "${range!.start.hour.toString()}:${range.start.minute.toString()} to ${range.end.hour.toString()}:${range.end.minute.toString()}";
                    setState(() {
                      print("Time :  ${range.start.hour.toString()}:${range.start.minute.toString()} "
                          "${range.end.hour.toString()}:${range.end.minute.toString()}"
                      );
                    });},
              ),
              /*SizedBox(
                height: 40,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 00, 00, 00),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    //21
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("11:00")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("11:30")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("12:00")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("12:30")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("13:00")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("13:30")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("14:00")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("14:30")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("15:00")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("18:00")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("18:30")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("19:00")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("19:30")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("20:00")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("20:30")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("21:00")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("21:30")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("22:00")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("22:30")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("23:00")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyDivider.withOpacity(0.2)
                        ),
                        child: const Center(
                            child: Text("23:30")
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),*/
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                  onTap: () async {
                    var dataName = await firebase.collection('User').get();
                    for(var i in dataName.docChanges){
                      if(i.doc.get('email') == FirebaseAuth.instance.currentUser!.email){
                        print("UserName ${i.doc.get('fullName')}");
                        fullName = i.doc.get('fullName');
                        break;
                      }
                    }
                    print("email${FirebaseAuth.instance.currentUser!.email} person $personSend || date $dateSend || time $timeSend || "
                        "restName ${widget.doc!.get("name")} || status pending ||"
                        " userName $fullName");
                    Provider.of<RestaurantBookProvider>(context,listen: false).
                    bookTable(
                        context,
                        FirebaseAuth.instance.currentUser!.email,
                        personSend.toString(),
                        dateSend,
                        timeSend,
                        "${widget.doc!.get("name")}",
                        "Pending",
                        fullName,
                        "${widget.doc!.get("shopOwnerEmail")}"
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 90,
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
                        child: Text("Book",
                          style: TextStyle(
                              color: AppColor.white,
                              fontFamily: AppFont.semiBold,
                              fontSize: 20
                          ),
                        )
                    ),
                  )
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
