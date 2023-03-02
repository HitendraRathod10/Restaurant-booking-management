import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_management/Admin/Add%20Restaurant/design/add_restaurant_screen.dart';
import 'package:restaurant_booking_management/Admin/My%20Restaurants/design/my_restaurants_screen.dart';
import 'package:restaurant_booking_management/Admin/Permission/design/permission_screen_admin.dart';
import 'package:restaurant_booking_management/Login/design/login_screen.dart';
import 'package:restaurant_booking_management/utils/app_image.dart';
import 'package:restaurant_booking_management/utils/dashboard_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Signup/provider/signup_provider.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_font.dart';
import '../../Profile/design/profile_screen_admin.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({Key? key}) : super(key: key);

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {

  check() async {
    SharedPreferences prefg = await SharedPreferences.getInstance();
    prefg.setBool("key", true);
  }

  /*notificationOnTap() async {
    // await flutterLocalNotificationsPlugin.cancelAll();
    // For background || When app is kill
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? event) async {
      if (event != null) {
        debugPrint("notificationOnTap HomeScreenAdmin getInitialMessage");
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>PermissionScreenAdmin()), (route) => false);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const PermissionScreenAdmin()));
      }
    });
    // For background || When app is not kill but in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("notificationOnTap HomeScreenAdmin onMessageOpenedApp ${message.data.values.first}");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PermissionScreenAdmin()));
    });
  }*/
  /*getNotification(context) async {
    debugPrint("getNotification HomeScreenAdmin start");
    await Firebase.initializeApp();
    enableIOSNotifications();
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false, requestAlertPermission: false);
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid,iOS: initializationSettingsIOS,);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                icon: "@mipmap/ic_launcher",
              ),
              iOS: const DarwinNotificationDetails(),
            ));
        debugPrint("getNotification HomeScreenAdmin notification != null");
      }
      var androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
      var iOSSettings = DarwinInitializationSettings(requestSoundPermission: false, requestBadgePermission: false, requestAlertPermission: false,);
      var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
      flutterLocalNotificationsPlugin.initialize(initSetttings,onDidReceiveNotificationResponse: onSelectLocalNotification);
    });
  }
  onSelectLocalNotification(payload) async {
    // await flutterLocalNotificationsPlugin.cancelAll();
    debugPrint("onSelectLocalNotification HomeScreenAdmin");
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PermissionScreenAdmin()));
  }*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
    // notificationOnTap();
    // getNotification(context);
  }
  Future<void> enableIOSNotifications() async {
    debugPrint("enableIOSNotifications HomeScreenAdmin");
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appColor.withOpacity(0.9),
          title: Transform.translate(
            offset: const Offset(-20.0, 0.0),
              child: const Text("Home",style: TextStyle(fontFamily: AppFont.semiBold),)
          ),
        ),
        drawer: Drawer(
        backgroundColor: AppColor.white,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser?.email).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Object?>?> snapshot) {
              if(snapshot.connectionState == ConnectionState.none){
                return const Text('Something went wrong');
              }
              else if(!snapshot.hasData){
                return const Text('Please wait');
              }else{
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  children: [
                    SizedBox(
                      height: 150,
                      child: DrawerHeader(
                          margin: const EdgeInsets.fromLTRB(20,18,00,00),
                          padding: const EdgeInsets.all(0.0),
                          decoration: const BoxDecoration(
                            // color: AppColor.red_bg,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: Container(
                                    color: AppColor.appColor,
                                    height: 70,width: 70,
                                    child: Center(
                                      child: Text('${data['fullName']?.substring(0,1).toUpperCase()}',
                                        style: const TextStyle(color: AppColor.white,fontSize: 30,fontFamily: AppFont.medium),),
                                    )
                                ),
                              ),
                              // ClipOval(
                              //     child:
                              //     Image.network('https://miro.medium.com/max/1400/0*0fClPmIScV5pTLoE.jpg',height: 70,width: 70,fit: BoxFit.fill)
                              // ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  const SizedBox(height: 5),
                                  Text('${data['fullName']}',style: const TextStyle(fontSize: 18,fontFamily: AppFont.regular),overflow: TextOverflow.ellipsis),
                                  Text('${FirebaseAuth.instance.currentUser?.email}',style: const TextStyle(color: AppColor.blackColor,fontFamily: AppFont.regular),overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ],
                          )
                      ),
                    ),
                    const Divider(height: 1,color: AppColor.greyDivider,),
                    SizedBox(
                      height: 40,
                      child: ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('Home',style: TextStyle(fontFamily: AppFont.medium)),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profile',style: TextStyle(fontFamily: AppFont.medium)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileScreenAdmin()));
                      },
                    ),
                    const Divider(height: 1,color: AppColor.greyDivider,),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout',style: TextStyle(fontFamily: AppFont.medium)),
                      onTap: ()  async {
                        SharedPreferences prefg = await SharedPreferences.getInstance();
                        prefg.clear();
                        FirebaseAuth.instance.signOut();
                        final firebase = FirebaseFirestore.instance;
                        var dataNameFcmToken = await firebase.collection('User').where("email",isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
                        for(var i in dataNameFcmToken.docChanges){
                          if (!mounted) return;
                          Provider.of<SignupProvider>(context,listen: false).
                          insertDataUser(
                              "${i.doc.get("fullName")}",
                              "${i.doc.get("email")}",
                              "${i.doc.get("phone")}",
                              "${i.doc.get("userType")}",
                              ""
                          );
                        }
                        if (!mounted) return;
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
                      },
                    ),
                  ],
                );
              }
          }
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 20, 10, 00),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyRestaurantsScreen()));
                  },
                    child: dashboardDetailsWidget(
                        AppImage.r1,
                        "My Restaurants",
                        "",
                        AppColor.lightOrange
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 100, 00),
                child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddRestaurantScreen()));
                    },
                    child: dashboardDetailsWidget(
                        AppImage.addRestaurant,
                        "Add Restaurants",
                        "",
                        AppColor.lightGreen.withOpacity(0.4)
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 20, 10, 20),
                child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PermissionScreenAdmin()));
                    },
                    child: dashboardDetailsWidget(
                        AppImage.yesnoThree,
                        "Permission",
                        "",
                        AppColor.lightBlue.withOpacity(0.4)
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
