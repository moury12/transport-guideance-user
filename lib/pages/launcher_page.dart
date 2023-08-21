import 'package:flutter/material.dart';
import 'package:transport_guidance_user/pages/dashboard_page.dart';
import 'package:transport_guidance_user/pages/login_pages.dart';

import '../authservice/authentication.dart';

class LauncherPage extends StatelessWidget {
  static const String routeName ='/';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { Future.delayed(Duration.zero,(){
    if(AuthService.currentUser!=null){
      Navigator.pushReplacementNamed(context, DashboardPage.routeName);
    }
    else{
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    }
  });
    return Scaffold(body:
    Center(
      child:
      Image.asset('assets/logo2.png',
        height:150,width: 150,),



    ),
    );
  }
}
