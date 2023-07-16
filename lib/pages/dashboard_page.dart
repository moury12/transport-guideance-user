import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/pages/notification.dart';
import 'package:transport_guidance_user/pages/profile_page.dart';
import 'package:transport_guidance_user/pages/routes_page.dart';
import 'package:transport_guidance_user/providers/busProvider.dart';

import '../constant/notification_service.dart';
import '../providers/userProvider.dart';
import 'home_page.dart';
class DashboardPage extends StatefulWidget {
  static const String routeName ='/dash';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int index=0;
@override
  void didChangeDependencies() {
  Provider.of<UserProvider>(context, listen: false).getUserInfo();
  Provider.of<BusProvider>(context, listen: false).getAllBus();
  Provider.of<BusProvider>(context, listen: false).getAllNotification();
  Provider.of<BusProvider>(context, listen: false).getAllNotice();
  Provider.of<BusProvider>(context, listen: false).getAllSchedule();
    super.didChangeDependencies();
  }
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //print('Got a message whilst in the foreground!');
      //print('Message data: ${message.data}');

      if (message.notification != null) {
        //print('Message also contained a notification: ${message.notification}');
        NotificationService service = NotificationService();
        service.sendNotifications(message);
      }
      NotificationService service = NotificationService();
    });
    setupInteractedMessage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(   bottomNavigationBar: CurvedNavigationBar(items:[
      Icon(Icons.home,size: 25,color: Colors.white,),
      Icon(Icons.route,size: 25,color: Colors.white,),
      Icon(Icons.notifications,size: 25,color: Colors.white,),
      Icon(Icons.person,size: 25,color: Colors.white,),
    ],color: Colors.blue.shade200,backgroundColor: Colors.transparent,buttonBackgroundColor: Colors.red.shade200,
      index: index,
      height: 60,
      onTap: (selectedIndex){
        setState(() {
          index=selectedIndex;
        });
      },
    ),
      body: getSelectedPage(index: index),);
  }
  Widget getSelectedPage({required int index}) {
    Widget widget;
    switch(index){
      case 0:
        widget =HomePage();
        break;
      case 1:
        widget =RoutePage();
        break;
      case 2:
        widget =NotificationPage();
        break;
      case 3:
        widget =ProfilePage();
        break;
      default:
        widget =HomePage();
        break;
    }
    return widget;
  }
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
  void _handleMessage(RemoteMessage message) {
    if (message.data['key'] == 'reqdeny') {
      final id =message.data['value'];
      print(id);
      Provider.of<BusProvider>(context, listen: false).deleteRequestById(id).then((value)=>
        Navigator.pushNamed(context, NotificationPage.routeName));
      /*//final productModel = Provider.of<ProductProvider>(context, listen: false)
      .getProductByIdFromCache(id);*/
      Navigator.pushNamed(context, NotificationPage.routeName);
    } else if (message.data['key'] =='reqaccept'
    ) {
      final id = message.data['value'];
      Provider.of<BusProvider>(context, listen: false)
          .deleteRequestById(id)
          .then((value) => Navigator.pushNamed(context, NotificationPage.routeName));
    }
    else if (message.data['key'] =='not'
    ) {
      final id = message.data['value'];
     // Provider.of<BusProvider>(context, listen: false)
         // .deleteRequestById(id)
          //.then((value) =>
          Navigator.pushNamed(context, NotificationPage.routeName);
      //);
    }
  }
}
