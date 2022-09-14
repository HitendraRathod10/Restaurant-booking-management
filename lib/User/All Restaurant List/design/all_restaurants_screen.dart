import 'package:flutter/material.dart';

class AllRestaurantsScreen extends StatefulWidget {
  const AllRestaurantsScreen({Key? key}) : super(key: key);

  @override
  State<AllRestaurantsScreen> createState() => _AllRestaurantsScreenState();
}

class _AllRestaurantsScreenState extends State<AllRestaurantsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Home"),
          centerTitle: true,
        ),
      ),
    );
  }
}
