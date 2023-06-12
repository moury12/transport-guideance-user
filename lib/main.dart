
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/pages/alternativePath_page.dart';
import 'package:transport_guidance_user/pages/feedback_page.dart';
import 'package:transport_guidance_user/pages/launcher_page.dart';
import 'package:transport_guidance_user/pages/liveLocation_page.dart';
import 'package:transport_guidance_user/pages/login_pages.dart';
import 'package:transport_guidance_user/pages/notice_page.dart';
import 'package:transport_guidance_user/pages/notification.dart';
import 'package:transport_guidance_user/pages/qusen_ans_page.dart';
import 'package:transport_guidance_user/pages/register_page_users.dart';
import 'package:transport_guidance_user/pages/request_page.dart';
import 'package:transport_guidance_user/pages/routes_page.dart';
import 'package:transport_guidance_user/pages/buslist_page.dart';
import 'package:transport_guidance_user/pages/tickets_page.dart';
import 'package:transport_guidance_user/providers/busProvider.dart';
import 'package:transport_guidance_user/providers/userProvider.dart';

import 'pages/dashboard_page.dart';
import 'pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>UserProvider()),
    ChangeNotifierProvider(create: (context)=>BusProvider()),
  ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Transport Guideance',
        theme: ThemeData(
          textTheme: GoogleFonts.prataTextTheme(),
          primarySwatch: Colors.blueGrey,
      ),      builder: EasyLoading.init(),
    initialRoute: LauncherPage.routeName,
    routes: {
      LauncherPage.routeName:(_)=>const LauncherPage(),
      DashboardPage.routeName:(_)=>const DashboardPage(),
      AlternativePage.routeName:(_)=>const AlternativePage(),
      FeedbackPage.routeName:(_)=>const FeedbackPage(),
      LiveLocationPage.routeName:(_)=>const LiveLocationPage(),
      LoginPage.routeName:(_)=> LoginPage(),
      NoticePage.routeName:(_)=>const NoticePage(),
      NotificationPage.routeName:(_)=>const NotificationPage(),
      ProfilePage.routeName:(_)=>const ProfilePage(),
      RegisterPage.routeName:(_)=>const RegisterPage(),
      RequestPage.routeName:(_)=>const RequestPage(),
      RoutePage.routeName:(_)=>const RoutePage(),
      BusListPage.routeName:(_)=>const BusListPage(),
      TicketPage.routeName:(_)=>const TicketPage(),
      QusenAnsPage.routeName:(_)=>const QusenAnsPage(),
    }
    );
  }
}
