import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Home"),
          centerTitle: true,
          backgroundColor: AppColor.appColor.withOpacity(0.9),
        ),
        body: ListView.builder(
          controller: _controller,
          shrinkWrap: true,
          itemCount: choice.length,
          itemBuilder: (BuildContext context, index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantOverview()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 05, 10, 00),
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
                                    '${choice[index].products}',
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
                                    '${choice[index].resortname}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
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
                                          color: AppColor.appColor.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.star,color: Colors.amber,size: 20,),
                                          SizedBox(
                                            width: 02,
                                          ),
                                          Text("4.2",style: TextStyle(fontFamily: AppFont.bold,fontSize: 20,color: AppColor.white),)
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
                                    child: const Icon(Icons.location_on)),
                                const SizedBox(
                                  width: 07,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width/1.3,
                                    child: Text("${choice[index].address}",
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
                                        color: AppColor.greyDivider.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: const Icon(Icons.phone)),
                                const SizedBox(
                                  width: 07,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text("${choice[index].mobile}",
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
                                        color: AppColor.greyDivider.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    width: 30,
                                    child: Image.asset(AppImage.dishTwo)),
                                    // child: const Icon(Icons.restaurant)),
                                const SizedBox(
                                  width: 07,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/1.4,
                                  child: Text("${choice[index].food}",
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
        ),
      ),
    );
  }
}

class myList {
  String? address;
  String? apppen;
  String? mobile;
  String? products;
  String? resortname;
  String? food;
  myList({this.products, this.apppen, this.resortname, this.address, this.mobile, this.food});
}

List<myList> choice = <myList>[
  myList(
      products: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRV5xNLJEGjwKaThX33fzkTMKJoiuJPKhK2Uw&usqp=CAU',
      resortname: "Beach Resort Lux Beach Resort Lux Beach Resort Lux Beach Resort Lux Beach Resort Lux Beach Resort Lux",
      address: "Willow lane Rendezvous Bay, 2022 Japan Willow lane Rendezvous Bay, 2022 Japan Willow lane Rendezvous Bay, 2022 Japan",
      mobile: "9773012140977301214097730121409773012140977301214097730121409773012140",
    food: "Gujarati, Punjabi, SouthIndian, Rajasthani, chinese, Gujarati, Punjabi, SouthIndian, Rajasthani, chinese"
  ),
  myList(
      products: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3sq0Vv8Od43Ur-M3j96c7qOrrgLWyHgIgOg&usqp=CAU',
      resortname: "Fateh Sagar Resort",
      address: "Shivranjani Ahmedabad Gujrath, 2021 India",
      mobile: "+91 12345559",
      food: "Gujarati, Punjabi, SouthIndian, Rajasthani, chinese"),
  myList(
      products: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw9Cllmq4QAF9R0vjChfJuMI8gPywIx_sylw&usqp=CAU',
      resortname: "Alpha Resort Lux",
      address: "Willow lane Rendezvous Bay, 2020 USA",
      mobile: "+91 455559905",
      food: "Gujarati, Punjabi, SouthIndian, Rajasthani, chinese"),
  myList(
      products: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpE_1NB3RrUpo4rVlvV-DpEDAYf0fQd2yQ_Q&usqp=CAU',
      resortname: "Himal View Resort",
      address: "Mount Abu Hill STattion Sirohi Rajasthan 2019 India",
      mobile: "+91 6745559905",
      food: "Gujarati, Punjabi, SouthIndian, Rajasthani, chinese"),
  myList(
      products: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3sq0Vv8Od43Ur-M3j96c7qOrrgLWyHgIgOg&usqp=CAU',
      resortname: "Beach Resort Lux",
      address: "LD Ahmedabad Gujrath, 2021 India",
      mobile: "+91 1235559905",
      food: "Gujarati, Punjabi, SouthIndian, Rajasthani, chinese"),
  myList(
      products: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaJ9mfLyq7hPQe0t6lgZcyrtBHLkWxQxZf-g&usqp=CAU',
      resortname: "Beach Lux Resort",
      address: "Kalupur Ahmedabad Gujrath, 2021 India",
      mobile: "+91 2345559905",
      food: "Gujarati, Punjabi, SouthIndian, Rajasthani, chinese"),
  myList(
      products: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbr9p1Zr9c_7b-iA6xHGljdclz7xukS5FDXg&usqp=CAU',
      resortname: "Beach Lux Resort",
      address: "Kalupur Ahmedabad Gujrath, 2021 India",
      mobile: "+91 2345559905",
      food: "Gujarati, Punjabi, SouthIndian, Rajasthani, chinese"),
  myList(
      products: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaJ9mfLyq7hPQe0t6lgZcyrtBHLkWxQxZf-g&usqp=CAU',
      resortname: "Beach Lux Resort",
      address: "Kalupur Ahmedabad Gujrath, 2021 India",
      mobile: "+91 2345559905",
      food: "Gujarati, Punjabi, SouthIndian, Rajasthani, chinese"),
];
