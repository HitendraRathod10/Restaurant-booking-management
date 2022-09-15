import 'package:flutter/material.dart';

class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({Key? key}) : super(key: key);

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Restaurants"),
        ),
      ),
    );
  }
}
