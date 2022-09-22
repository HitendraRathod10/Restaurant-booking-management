import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_font.dart';
import '../../../utils/app_image.dart';

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
          centerTitle: true,
          backgroundColor: AppColor.appColor.withOpacity(0.9),
          title: Text("Permission Screen"),
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
                            const Text("Hitendra Rathod",
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
                        Image.asset(
                          AppImage.greenYes,
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          AppImage.redNo,
                          height: 30,
                          width: 30,
                        ),
                        // Icon(Icons.check_circle_outline,color: Colors.green,),
                        // Icon(Icons.cancel_outlined,color: Colors.red,)
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
