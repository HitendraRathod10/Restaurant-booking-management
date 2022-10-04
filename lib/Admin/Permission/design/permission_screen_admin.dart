import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../../../User/Restaurant Book/provider/restaurant_book_provider.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_font.dart';
import '../../../utils/app_image.dart';

class PermissionScreenAdmin extends StatefulWidget {
  const PermissionScreenAdmin({Key? key}) : super(key: key);

  @override
  State<PermissionScreenAdmin> createState() => _PermissionScreenAdminState();
}

class _PermissionScreenAdminState extends State<PermissionScreenAdmin> {

  loader(){
    EasyLoading.show(status: 'loading...');
  }
  final firebase = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.appColor.withOpacity(0.9),
          title: const Text("Permission Screen"),
        ),
        body: StreamBuilder(
          stream: firebase.collection('Booking').where("shopOwnerEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: AppColor.darkMaroon,));
            if(snapshot.data!.size ==0) {
              EasyLoading.dismiss();
              return const Center(
                child: Text("No Data found",
                  style: TextStyle(
                      fontFamily: AppFont.bold,
                      fontSize: 25
                  ),
                ),
              );
            }
            if(snapshot.hasData){
              EasyLoading.dismiss();
              return ListView.builder(
                  itemCount: snapshot.data!.docChanges.length,
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
                                  Text("${snapshot.data!.docChanges[index].doc.get("userName")}",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontFamily: AppFont.semiBold
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 07,
                                  ),
                                  Row(
                                    children: [
                                      Text("${snapshot.data!.docChanges[index].doc.get("date")}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: AppFont.regular
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text("${snapshot.data!.docChanges[index].doc.get("time")}",
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
                                  Text("${snapshot.data!.docChanges[index].doc.get("person")} Persons",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: AppFont.regular
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              snapshot.data!.docChanges[index].doc.get("statusOfBooking") == "Approved" ?
                              const Text("Approved") :
                              snapshot.data!.docChanges[index].doc.get("statusOfBooking") == "Rejected" ?
                              const Text("rejected") :
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      EasyLoading.show(status: "Loading Please wait for some time");
                                      await firebase.collection("Booking").
                                      doc("${snapshot.data!.docChanges[index].doc.get("restaurantName")} "
                                          "${snapshot.data!.docChanges[index].doc.get("date")} "
                                          "${snapshot.data!.docChanges[index].doc.get("time")}").update({
                                        "email" : snapshot.data!.docChanges[index].doc.get("email"),
                                        "person" : snapshot.data!.docChanges[index].doc.get("person"),
                                        "date" : snapshot.data!.docChanges[index].doc.get("date"),
                                        "time" : snapshot.data!.docChanges[index].doc.get("time"),
                                        "shopOwnerEmail" : snapshot.data!.docChanges[index].doc.get("shopOwnerEmail"),
                                        "restaurantName" : snapshot.data!.docChanges[index].doc.get("restaurantName"),
                                        "statusOfBooking" : "Approved",
                                        "userName" : snapshot.data!.docChanges[index].doc.get("userName")
                                      });
                                      setState(() {});
                                      EasyLoading.dismiss();
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
                                      doc("${snapshot.data!.docChanges[index].doc.get("restaurantName")} "
                                          "${snapshot.data!.docChanges[index].doc.get("date")} "
                                          "${snapshot.data!.docChanges[index].doc.get("time")}").update({
                                        "email" : snapshot.data!.docChanges[index].doc.get("email"),
                                        "person" : snapshot.data!.docChanges[index].doc.get("person"),
                                        "date" : snapshot.data!.docChanges[index].doc.get("date"),
                                        "time" : snapshot.data!.docChanges[index].doc.get("time"),
                                        "shopOwnerEmail" : snapshot.data!.docChanges[index].doc.get("shopOwnerEmail"),
                                        "restaurantName" : snapshot.data!.docChanges[index].doc.get("restaurantName"),
                                        "statusOfBooking" : "Rejected",
                                        "userName" : snapshot.data!.docChanges[index].doc.get("userName")
                                      });
                                      setState(() {});
                                      EasyLoading.dismiss();
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
            }else{
              return loader();
            }
          }
        ),
      ),
    );
  }
}
