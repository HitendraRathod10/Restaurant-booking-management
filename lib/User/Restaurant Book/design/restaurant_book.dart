import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_booking_management/utils/app_font.dart';


import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';

class RestaurantBook extends StatefulWidget {
  const RestaurantBook({Key? key}) : super(key: key);

  @override
  State<RestaurantBook> createState() => _RestaurantBookState();
}

class _RestaurantBookState extends State<RestaurantBook> {

  final currentDate = DateTime.now();
  final dayFormatter = DateFormat('dd');
  final monthFormatter = DateFormat('MMM');
  List dates = [];
  DateTime? date;

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
                    style: TextStyle(fontFamily: AppFont.bold,fontSize: 20),
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
                              Container(
                                height: 40,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.greyDivider.withOpacity(0.2)
                                ),
                                child: Center(child: Text("${index+1} Person")),
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
                                Container(
                                  height: 40,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.greyDivider.withOpacity(0.2)
                                  ),
                                  child: Center(
                                    // child: methodForDate(),
                                      child: Text("${dayFormatter.format(dates[index])} ${monthFormatter.format(dates[index])}")
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
              SizedBox(
                height: 40,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 00, 00, 00),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
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
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
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
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
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
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
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
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("01:00")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("01:30")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("02:00")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("02:30")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("03:00")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("06:00")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("06:30")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("07:00")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("07:30")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("08:00")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("08:30")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("09:00")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("09:30")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("10:00")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.greyDivider.withOpacity(0.2)
                      ),
                      child: const Center(
                          child: Text("10:30")
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
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
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
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
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                  onTap: () async {

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
