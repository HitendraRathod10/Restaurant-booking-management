import 'package:flutter/material.dart';
import 'package:restaurant_booking_management/utils/app_color.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';

class MyBookingStatusScreen extends StatefulWidget {
  const MyBookingStatusScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingStatusScreen> createState() => _MyBookingStatusScreenState();
}

class _MyBookingStatusScreenState extends State<MyBookingStatusScreen> {
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
        body: ListView.builder(
          itemCount: 10,
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
                            const Text("Kshitij Restaurant",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: AppFont.semiBold
                              ),
                            ),
                            const SizedBox(
                              height: 07,
                            ),
                            Row(
                              children: const [
                                Text("Sep 21,2022",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: AppFont.regular
                                ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("20:30",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: AppFont.regular
                                ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 07,
                            ),
                            const Text("5 Persons",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: AppFont.regular
                            ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(07),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(05),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          child: Text("Pending",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontFamily: AppFont.regular,
                            fontSize: 20
                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
