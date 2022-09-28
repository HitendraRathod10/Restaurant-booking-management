import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:restaurant_booking_management/Admin/My%20Restaurants/design/my_restaurant_overview.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';

import '../../../utils/app_color.dart';

class MyRestaurantsScreen extends StatefulWidget {
  const MyRestaurantsScreen({Key? key}) : super(key: key);

  @override
  State<MyRestaurantsScreen> createState() => _MyRestaurantsScreenState();
}

class _MyRestaurantsScreenState extends State<MyRestaurantsScreen> {

  final firebase = FirebaseFirestore.instance;
  ScrollController _controller = ScrollController();

  loader(){
    EasyLoading.show(status: 'loading...');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("My Restaurants",style: TextStyle(fontFamily: AppFont.semiBold),),
            backgroundColor: AppColor.appColor.withOpacity(0.9),
            centerTitle: true,
          ),
          body: StreamBuilder(
            stream: firebase.collection('User').doc(FirebaseAuth.instance.currentUser!.email).collection("My Restaurants").snapshots(),
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
              if(snapshot.hasData) {
              EasyLoading.dismiss();
              return ListView.builder(
                controller: _controller,
                shrinkWrap: true,
                itemCount: snapshot.data!.docChanges.length,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyRestaurantOverview(doc: snapshot.data!.docChanges[index].doc,)));
                        },
                        child: Card(
                          color: Colors.white.withOpacity(1.0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 00),
                            child: Column(
                              children: [
                                Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                        borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(10)),
                                        child: Image.network(
                                          '${snapshot.data!.docChanges[index].doc.get("image")}',
                                          height: 180,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    Positioned(
                                        bottom: 08,
                                        left: 08,
                                        right: 80,
                                        child: Text(
                                          '${snapshot.data!.docChanges[index].doc.get("name")}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: AppFont.semiBold,
                                            fontSize: 30,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      ),
                                    Positioned(
                                      bottom: 08,
                                      right: 08,
                                      child: Container(
                                        padding: const EdgeInsets.all(02),
                                        decoration: BoxDecoration(
                                          color: AppColor.greyDivider.withOpacity(0.9),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.star,color: Colors.yellow,size: 20,),
                                            SizedBox(
                                              width: 02,
                                            ),
                                            Text("4.5",style: TextStyle(fontFamily: AppFont.semiBold,fontSize: 20),)
                                          ],
                                        ),
                                      )
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(02),
                                        decoration: BoxDecoration(
                                            color: AppColor.greyDivider.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(02),
                                          child: Icon(Icons.location_on,size: 22,),
                                        )),
                                    const SizedBox(
                                      width: 07,
                                    ),
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width/1.3,
                                        child: Text("${snapshot.data!.docChanges[index].doc.get("area")} "
                                            "${snapshot.data!.docChanges[index].doc.get("city")} "
                                            "${snapshot.data!.docChanges[index].doc.get("state")}",
                                          style: const TextStyle(
                                            fontFamily: AppFont.regular,
                                            fontSize: 17
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(02),
                                      decoration: BoxDecoration(
                                        color: AppColor.greyDivider.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Icon(Icons.phone,size: 22,),
                                        )),
                                    const SizedBox(
                                      width: 07,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text("${snapshot.data!.docChanges[index].doc.get("phone")}",
                                          style: const TextStyle(fontFamily: AppFont.regular,fontSize: 17),
                                          overflow: TextOverflow.ellipsis),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
              }
              else{
                return loader();
              }
            }
          )),
    );
  }
}
