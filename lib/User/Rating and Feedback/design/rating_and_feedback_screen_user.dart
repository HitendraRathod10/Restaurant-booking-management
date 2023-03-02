import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_font.dart';
//ignore: must_be_immutable
class RatingAndFeedbackScreen extends StatefulWidget {
  String? name;
  RatingAndFeedbackScreen({super.key, required this.name});
  // const RatingAndFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<RatingAndFeedbackScreen> createState() =>
      _RatingAndFeedbackScreenState();
}

class _RatingAndFeedbackScreenState extends State<RatingAndFeedbackScreen> {
  final firebase = FirebaseFirestore.instance;
  loader() {
    EasyLoading.show(status: 'loading...');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appColor.withOpacity(0.9),
          title: const Text(
            "Reviews And Ratings",
            style: TextStyle(fontFamily: AppFont.regular),
          ),
        ),
        body: StreamBuilder(
            stream: firebase
                .collection('Rating')
                .where("restaurantName", isEqualTo: "${widget.name}")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColor.darkMaroon,
                ));
              }
              if (snapshot.data!.size == 0) {
                EasyLoading.dismiss();
                return const Center(
                  child: Text(
                    "No Data found",
                    style: TextStyle(fontFamily: AppFont.bold, fontSize: 25),
                  ),
                );
              }
              if (snapshot.hasData) {
                EasyLoading.dismiss();
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                        child: Container(
                          // height: 150,
                          decoration: const BoxDecoration(
                              // color: AppColor.greyDivider.withOpacity(0.4),
                              ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColor.appColor,
                                    child: Text(
                                      "${snapshot.data!.docs[index]["userName"].substring(0, 1).toUpperCase()}",
                                      style: const TextStyle(
                                          color: AppColor.white,
                                          fontFamily: AppFont.regular),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${snapshot.data!.docs[index]["userName"]}',
                                    style: const TextStyle(
                                        fontFamily: AppFont.medium,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RatingBar.builder(
                                initialRating: snapshot.data!.docs[index]["rating"],
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: 20,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  debugPrint('rating $rating');
                                  setState(() {});
                                },
                                ignoreGestures: true,
                              ),
                              const SizedBox(
                                height: 04,
                              ),
                              Text(
                                "${snapshot.data!.docs[index]["feedback"]}",
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: AppFont.regular),
                              ),
                              const Text("___________")
                            ],
                          ),
                        ),
                      );
                    });
              }
              else {
                return loader();
              }
            }),
      ),
    );
  }
}
