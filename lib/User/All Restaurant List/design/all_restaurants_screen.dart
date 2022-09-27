import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:restaurant_booking_management/User/Restaurant%20Overview/design/restaurant_overview.dart';
import 'package:restaurant_booking_management/utils/app_image.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_font.dart';

class AllRestaurantsScreen extends StatefulWidget {
  const AllRestaurantsScreen({Key? key}) : super(key: key);

  @override
  State<AllRestaurantsScreen> createState() => _AllRestaurantsScreenState();
}

class _AllRestaurantsScreenState extends State<AllRestaurantsScreen> {

  ScrollController _controller = ScrollController();
  final firebase = FirebaseFirestore.instance;

  loader(){
    EasyLoading.show(status: 'loading...');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Home",style: TextStyle(fontFamily: AppFont.semiBold),),
          centerTitle: true,
          backgroundColor: AppColor.appColor.withOpacity(0.9),
        ),
        body: StreamBuilder(
          stream: firebase.collection('All Restaurants').snapshots(),
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
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => RestaurantOverview(doc: snapshot.data!.docChanges[index].doc,)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 05, 10, 00),
                          child: Card(
                            color: Colors.white.withOpacity(1.0),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10, 10, 10, 00),
                              child: Column(
                                children: [
                                  Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: const BorderRadius
                                            .vertical(
                                            top: Radius.circular(10)),
                                        child: Image.network(
                                          '${snapshot.data!.docChanges[index].doc.get("image")}',
                                          height: 180,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      /*Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20.0),
                                                color: Colors.white),
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.only(right: 15, top: 15),
                                            child: RichText(
                                              text: TextSpan(children: [
                                                const WidgetSpan(
                                                  child: Icon(
                                                    Icons.access_time,
                                                    size: 15,
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: (index % 2 == 0)
                                                        ? "  Pending  "
                                                        : "  Approved  ",
                                                    style:
                                                        const TextStyle(color: Colors.black)),
                                              ]),
                                            ),
                                          ),
                                        ],
                                      ),*/
                                      /*Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35.0),
                                                color: Colors.blue),
                                            padding: const EdgeInsets.all(15),
                                            margin: const EdgeInsets.only(left: 10, top: 10),
                                            child: const Text(
                                              "View Details",
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),*/
                                      Positioned(
                                        bottom: 08,
                                        left: 08,
                                        right: 80,
                                        child: Text(
                                          '${snapshot.data!.docChanges[index].doc.get("name")}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 27,
                                            fontFamily: AppFont.semiBold
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
                                                color: AppColor.greyDivider
                                                    .withOpacity(0.9),
                                                borderRadius: BorderRadius
                                                    .circular(10)
                                            ),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.star,
                                                  color: Colors.amber,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 02,
                                                ),
                                                Text("4.2",
                                                  style: TextStyle(
                                                    fontFamily: AppFont.semiBold,
                                                    fontSize: 20,
                                                    color: AppColor.white
                                                  ),
                                                )
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
                                              color: AppColor.greyDivider
                                                  .withOpacity(0.3),
                                              borderRadius: BorderRadius
                                                  .circular(20)
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(2),
                                            child: Icon(Icons.location_on,size: 20,),
                                          )),
                                      const SizedBox(
                                        width: 07,
                                      ),
                                      SizedBox(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width / 1.3,
                                          child: Text(
                                                "${snapshot.data!.docChanges[index].doc.get("area")} "
                                                "${snapshot.data!.docChanges[index].doc.get("city")} "
                                                "${snapshot.data!.docChanges[index].doc.get("state")}",
                                            style: const TextStyle(
                                              fontFamily: AppFont.regular,
                                              fontSize: 17
                                            ),
                                            overflow: TextOverflow.ellipsis,))
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
                                              color: AppColor.greyDivider
                                                  .withOpacity(0.3),
                                              borderRadius: BorderRadius
                                                  .circular(20)
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(2),
                                            child: Icon(Icons.phone,size: 20,),
                                          )),
                                      const SizedBox(
                                        width: 07,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Text("${snapshot.data!.docChanges[index].doc.get("phone")}",
                                            style: const TextStyle(
                                                fontFamily: AppFont.regular,
                                                fontSize: 17
                                            ),
                                            overflow: TextOverflow.ellipsis),
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
                                              color: AppColor.greyDivider
                                                  .withOpacity(0.3),
                                              borderRadius: BorderRadius
                                                  .circular(20)
                                          ),
                                          width: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Image.asset(AppImage.dishTwo,height: 20,width: 20),
                                          )),
                                      // child: const Icon(Icons.restaurant)),
                                      const SizedBox(
                                        width: 07,
                                      ),
                                      SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 1.4,
                                        child: Text("${snapshot.data!.docChanges[index].doc.get("food")}",
                                            style: const TextStyle(
                                                fontFamily: AppFont.regular,
                                                fontSize: 17
                                            ),
                                            overflow: TextOverflow.ellipsis),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }else{
              return loader();
            }
          }
        ),
      ),
    );
  }
}