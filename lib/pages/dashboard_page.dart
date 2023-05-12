import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/pages/notification.dart';
import 'package:transport_guidance_user/pages/profile_page.dart';
import 'package:transport_guidance_user/pages/routes_page.dart';

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
    super.didChangeDependencies();
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
}
