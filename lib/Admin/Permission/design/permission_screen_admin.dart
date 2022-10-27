import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/Home/design/home_screen_admin.dart';
import '../../../Services/PushNotificationService.dart';
import '../../../User/Restaurant Book/provider/restaurant_book_provider.dart';
import '../../../main.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_font.dart';
import '../../../utils/app_image.dart';

class PermissionScreenAdmin extends StatefulWidget {
  const PermissionScreenAdmin({Key? key}) : super(key: key);

  @override
  State<PermissionScreenAdmin> createState() => _PermissionScreenAdminState();
}

class _PermissionScreenAdminState extends State<PermissionScreenAdmin> {

  // loader(){
  //   EasyLoading.show(status: 'loading...');
  // }
  final firebase = FirebaseFirestore.instance;
  forApprove(index) async {
    var restaurantName,date,time,email,person,shopOwnerEmail,userName;
    var collection = FirebaseFirestore.instance.collection('Booking').where("shopOwnerEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email);
    var querySnapshot = await collection.get();

    print("index ${index} ${querySnapshot.docs[index].get("restaurantName")} "
        "${querySnapshot.docs[index].get("date")} "
        "${querySnapshot.docs[index].get("time")} "
        "${querySnapshot.docs[index].get("person")}");

    restaurantName = querySnapshot.docs[index].get("restaurantName");
    date = querySnapshot.docs[index].get("date");
    time = querySnapshot.docs[index].get("time");
    email = querySnapshot.docs[index].get("email");
    person = querySnapshot.docs[index].get("person");
    shopOwnerEmail = querySnapshot.docs[index].get("shopOwnerEmail");
    userName = querySnapshot.docs[index].get("userName");

    // collection.doc("$restaurantName $date $time $email").update({
    //     "email" : email,
    //     "person" : person,
    //     "date" : date,
    //     "time" : time,
    //     "shopOwnerEmail" : shopOwnerEmail,
    //     "restaurantName" : restaurantName,
    //     "statusOfBooking" : "Approved",
    //     "userName" : userName
    // });
    setState(() {});
    // await firebase.collection("Booking").
    // doc("${snapshot.data!.docChanges[index].doc.get("restaurantName")} "
    //     "${snapshot.data!.docChanges[index].doc.get("date")} "
    //     "${snapshot.data!.docChanges[index].doc.get("time")} "
    //     "${snapshot.data!.docChanges[index].doc.get("email")}").update({
    //   "email" : snapshot.data!.docChanges[index].doc.get("email"),
    //   "person" : snapshot.data!.docChanges[index].doc.get("person"),
    //   "date" : snapshot.data!.docChanges[index].doc.get("date"),
    //   "time" : snapshot.data!.docChanges[index].doc.get("time"),
    //   "shopOwnerEmail" : snapshot.data!.docChanges[index].doc.get("shopOwnerEmail"),
    //   "restaurantName" : snapshot.data!.docChanges[index].doc.get("restaurantName"),
    //   "statusOfBooking" : "Approved",
    //   "userName" : snapshot.data!.docChanges[index].doc.get("userName")
    // });
  }
  loader() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
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
          backgroundColor: AppColor.appColor.withOpacity(0.9),
          title: const Text("Permission Screen"),
          leading: IconButton(
            onPressed: () {
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreenAdmin()));
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeScreenAdmin()), (route) => false);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: StreamBuilder(
          stream: firebase.collection('Booking').where("shopOwnerEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
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
            else if (snapshot.requireData.docChanges.isNotEmpty){
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
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${snapshot.data!.docs[index]["userName"]}",
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontFamily: AppFont.semiBold
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 07,
                                    ),
                                    Text("${snapshot.data!.docs[index]['restaurantName']}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: AppFont.regular
                                      ),
                                      overflow: TextOverflow.ellipsis,
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
                                    Text("${snapshot.data!.docs[index]['person']} Persons",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: AppFont.regular
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              snapshot.data!.docs[index]["statusOfBooking"] == "Approved" ?
                              const Text("Approved") :
                              snapshot.data!.docs[index]["statusOfBooking"] == "Rejected" ?
                              const Text("Rejected") :
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      EasyLoading.show(status: "Loading Please wait for some time");
                                      // forApprove(index);
                                      await firebase.collection("Booking").
                                      doc("${snapshot.data!.docs[index]["restaurantName"]} "
                                          "${snapshot.data!.docs[index]["date"]} "
                                          "${snapshot.data!.docs[index]["time"]} "
                                          "${snapshot.data!.docs[index]["email"]}").update({
                                        "email" : snapshot.data!.docs[index]["email"],
                                        "person" : snapshot.data!.docs[index]["person"],
                                        "date" : snapshot.data!.docs[index]["date"],
                                        "time" : snapshot.data!.docs[index]["time"],
                                        "shopOwnerEmail" : snapshot.data!.docs[index]["shopOwnerEmail"],
                                        "restaurantName" : snapshot.data!.docs[index]["restaurantName"],
                                        "statusOfBooking" : "Approved",
                                        "userName" : snapshot.data!.docs[index]["userName"]
                                      });
                                      // setState(() {});
                                      EasyLoading.dismiss();
                                      var dataNameFcmToken = await firebase.collection('User').where("email",isEqualTo: snapshot.data!.docs[index]["email"]).get();
                                      String? token;
                                      for(var i in dataNameFcmToken.docChanges){
                                        token = i.doc.get("fcmToken");
                                      }
                                      PushNotificationService().
                                      notificationToUserForStatus(
                                          token,
                                          snapshot.data!.docs[index]["restaurantName"],
                                          "Approved for ${snapshot.data!.docs[index]["person"]} person",
                                          "on ${snapshot.data!.docs[index]["date"]} ${snapshot.data!.docs[index]["time"]}"
                                      );
                                    },
                                    child: Image.asset(
                                      AppImage.greenYes,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      EasyLoading.show(status: "Loading Please wait for some time");
                                      await firebase.collection("Booking").
                                      doc("${snapshot.data!.docs[index]["restaurantName"]} "
                                          "${snapshot.data!.docs[index]["date"]} "
                                          "${snapshot.data!.docs[index]["time"]} "
                                          "${snapshot.data!.docs[index]["email"]}").update({
                                        "email" : snapshot.data!.docs[index]["email"],
                                        "person" : snapshot.data!.docs[index]["person"],
                                        "date" : snapshot.data!.docs[index]["date"],
                                        "time" : snapshot.data!.docs[index]["time"],
                                        "shopOwnerEmail" : snapshot.data!.docs[index]["shopOwnerEmail"],
                                        "restaurantName" : snapshot.data!.docs[index]["restaurantName"],
                                        "statusOfBooking" : "Rejected",
                                        "userName" : snapshot.data!.docs[index]["userName"]
                                      });
                                      // setState(() {});
                                      EasyLoading.dismiss();
                                      var dataNameFcmToken = await firebase.collection('User').where("email",isEqualTo: snapshot.data!.docs[index]["email"]).get();
                                      String? token;
                                      for(var i in dataNameFcmToken.docChanges){
                                        token = i.doc.get("fcmToken");
                                      }
                                      PushNotificationService().
                                      notificationToUserForStatus(
                                          token,
                                          snapshot.data!.docs[index]["restaurantName"],
                                          "Rejected for ${snapshot.data!.docs[index]["person"]} person",
                                          "on ${snapshot.data!.docs[index]["date"]} ${snapshot.data!.docs[index]["time"]}"
                                      );
                                    },
                                    child: Image.asset(
                                      AppImage.redNo,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ],
                              ),
                              // Icon(Icons.check_circle_outline,color: Colors.green,),
                              // Icon(Icons.cancel_outlined,color: Colors.red,)
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            /*else if(snapshot.hasData){
              // EasyLoading.dismiss();
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${snapshot.data!.docs[index]["userName"]}",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontFamily: AppFont.semiBold
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 07,
                                  ),
                                  Text("${snapshot.data!.docs[index]['restaurantName']}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: AppFont.regular
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
                                  Text("${snapshot.data!.docs[index]['person']} Persons",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: AppFont.regular
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              snapshot.data!.docs[index]["statusOfBooking"] == "Approved" ?
                              const Text("Approved") :
                              snapshot.data!.docs[index]["statusOfBooking"] == "Rejected" ?
                              const Text("Rejected") :
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      EasyLoading.show(status: "Loading Please wait for some time");
                                      // forApprove(index);
                                      await firebase.collection("Booking").
                                      doc("${snapshot.data!.docs[index]["restaurantName"]} "
                                          "${snapshot.data!.docs[index]["date"]} "
                                          "${snapshot.data!.docs[index]["time"]} "
                                          "${snapshot.data!.docs[index]["email"]}").update({
                                        "email" : snapshot.data!.docs[index]["email"],
                                        "person" : snapshot.data!.docs[index]["person"],
                                        "date" : snapshot.data!.docs[index]["date"],
                                        "time" : snapshot.data!.docs[index]["time"],
                                        "shopOwnerEmail" : snapshot.data!.docs[index]["shopOwnerEmail"],
                                        "restaurantName" : snapshot.data!.docs[index]["restaurantName"],
                                        "statusOfBooking" : "Approved",
                                        "userName" : snapshot.data!.docs[index]["userName"]
                                      });
                                      // setState(() {});
                                      EasyLoading.dismiss();
                                      var dataNameFcmToken = await firebase.collection('User').where("email",isEqualTo: snapshot.data!.docs[index]["email"]).get();
                                      String? token;
                                      for(var i in dataNameFcmToken.docChanges){
                                        token = i.doc.get("fcmToken");
                                      }
                                      PushNotificationService().
                                      notificationToUserForStatus(
                                          token,
                                          snapshot.data!.docs[index]["restaurantName"],
                                          "Approved for ${snapshot.data!.docs[index]["person"]} person",
                                          "on ${snapshot.data!.docs[index]["date"]}"
                                      );
                                    },
                                    child: Image.asset(
                                      AppImage.greenYes,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      EasyLoading.show(status: "Loading Please wait for some time");
                                      await firebase.collection("Booking").
                                      doc("${snapshot.data!.docs[index]["restaurantName"]} "
                                          "${snapshot.data!.docs[index]["date"]} "
                                          "${snapshot.data!.docs[index]["time"]} "
                                          "${snapshot.data!.docs[index]["email"]}").update({
                                        "email" : snapshot.data!.docs[index]["email"],
                                        "person" : snapshot.data!.docs[index]["person"],
                                        "date" : snapshot.data!.docs[index]["date"],
                                        "time" : snapshot.data!.docs[index]["time"],
                                        "shopOwnerEmail" : snapshot.data!.docs[index]["shopOwnerEmail"],
                                        "restaurantName" : snapshot.data!.docs[index]["restaurantName"],
                                        "statusOfBooking" : "Rejected",
                                        "userName" : snapshot.data!.docs[index]["userName"]
                                      });
                                      // setState(() {});
                                      EasyLoading.dismiss();
                                      var dataNameFcmToken = await firebase.collection('User').where("email",isEqualTo: snapshot.data!.docs[index]["email"]).get();
                                      String? token;
                                      for(var i in dataNameFcmToken.docChanges){
                                        token = i.doc.get("fcmToken");
                                      }
                                      PushNotificationService().
                                      notificationToUserForStatus(
                                          token,
                                          snapshot.data!.docs[index]["restaurantName"],
                                          "Rejected for ${snapshot.data!.docs[index]["person"]} person",
                                          "on ${snapshot.data!.docs[index]["date"]}"
                                      );
                                    },
                                    child: Image.asset(
                                      AppImage.redNo,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ],
                              ),
                              // Icon(Icons.check_circle_outline,color: Colors.green,),
                              // Icon(Icons.cancel_outlined,color: Colors.red,)
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }*/
            else{
              return  const Center(child: CircularProgressIndicator(color: AppColor.darkMaroon,));
            }
          }
        ),
      ),
    );
  }
}
