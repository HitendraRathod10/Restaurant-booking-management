import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:restaurant_booking_management/utils/app_color.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';

import '../../../main.dart';

class MyBookingStatusScreen extends StatefulWidget {
  const MyBookingStatusScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingStatusScreen> createState() => _MyBookingStatusScreenState();
}

class _MyBookingStatusScreenState extends State<MyBookingStatusScreen> {

  loader() async {
    // await flutterLocalNotificationsPlugin.cancelAll();
  }
  final firebase = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loader();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.appColor.withOpacity(0.9),
          title: const Text("My booking",
            style: TextStyle(
              fontFamily: AppFont.semiBold
            ),
          ),
        ),
        body: StreamBuilder(
          stream: firebase.collection('Booking').where("email",isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong",style: TextStyle(fontFamily: AppFont.medium)));
            }
            else if (!snapshot.hasData || snapshot.requireData.docChanges.isEmpty) {
              return const Center(child: Text("No Data Found",style: TextStyle(fontFamily: AppFont.medium)));
            }
            else if (snapshot.requireData.docChanges.isNotEmpty) {
              EasyLoading.dismiss();
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    return SizedBox(
                      // height: 92,
                      child: Card(
                        color: index % 2 == 0 ? AppColor.white : Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 05,
                        margin: const EdgeInsets.all(05),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/1.5,
                                      child: Text("${snapshot.data!.docs[index]["restaurantName"]}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontFamily: AppFont.semiBold
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 07,
                                    ),
                                    Row(
                                      children: [
                                        Text("${snapshot.data!.docs[index]["date"]}",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: AppFont.regular
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text("${snapshot.data!.docs[index]["time"]}",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: AppFont.regular
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 07,
                                    ),
                                    Text("Person : ${snapshot.data!.docs[index]["person"]}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: AppFont.regular
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // const Spacer(),
                              snapshot.data!.docs[index]["statusOfBooking"] == "Pending" ?
                              Container(
                                padding: const EdgeInsets.all(07),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(05),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                child: Text("${snapshot.data!.docs[index]["statusOfBooking"]}",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontFamily: AppFont.regular,
                                      fontSize: 15
                                  ),
                                ),
                              ) :
                              snapshot.data!.docs[index]["statusOfBooking"] == "Rejected" ?
                              Container(
                                padding: const EdgeInsets.all(07),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(05),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.redAccent.shade400,
                                  ),
                                ),
                                child: Text("${snapshot.data!.docs[index]["statusOfBooking"]}",
                                  style: TextStyle(
                                      color: Colors.redAccent.shade400,
                                      fontFamily: AppFont.regular,
                                      fontSize: 18
                                  ),
                                ),
                              ) :
                              snapshot.data!.docs[index]["statusOfBooking"] == "Approved" ?
                              Container(
                                padding: const EdgeInsets.all(07),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(05),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.green.shade600
                                  ),
                                ),
                                child: Text("${snapshot.data!.docs[index]["statusOfBooking"]}",
                                  style: TextStyle(
                                      color: Colors.green.shade600,
                                      fontFamily: AppFont.semiBold,
                                      fontSize: 18
                                  ),
                                ),
                              ) : const SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            else{
              return  const Center(child: CircularProgressIndicator(color: AppColor.darkMaroon,));
            }
          }
        ),
      ),
    );
  }
}
