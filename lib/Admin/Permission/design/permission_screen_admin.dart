import 'package:flutter/material.dart';

class PermissionScreenAdmin extends StatefulWidget {
  const PermissionScreenAdmin({Key? key}) : super(key: key);

  @override
  State<PermissionScreenAdmin> createState() => _PermissionScreenAdminState();
}

class _PermissionScreenAdminState extends State<PermissionScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Permission Screen"),
        ),
      ),
    );
  }
}
