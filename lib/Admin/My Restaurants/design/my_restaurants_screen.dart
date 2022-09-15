import 'package:flutter/material.dart';

class MyRestaurantsScreen extends StatefulWidget {
  const MyRestaurantsScreen({Key? key}) : super(key: key);

  @override
  State<MyRestaurantsScreen> createState() => _MyRestaurantsScreenState();
}

class _MyRestaurantsScreenState extends State<MyRestaurantsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Restaurants"),
        ),
      ),
    );
  }
}
