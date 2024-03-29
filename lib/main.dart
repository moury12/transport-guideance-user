
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/pages/alternativePath_page.dart';
import 'package:transport_guidance_user/pages/busDetails.dart';
import 'package:transport_guidance_user/pages/feedback_page.dart';
import 'package:transport_guidance_user/pages/launcher_page.dart';
import 'package:transport_guidance_user/pages/tickets_page.dart';
import 'package:transport_guidance_user/pages/login_pages.dart';
import 'package:transport_guidance_user/pages/notice_page.dart';
import 'package:transport_guidance_user/pages/notification.dart';
import 'package:transport_guidance_user/pages/qusen_ans_page.dart';
import 'package:transport_guidance_user/pages/register_page_users.dart';
import 'package:transport_guidance_user/pages/request_page.dart';
import 'package:transport_guidance_user/pages/routes_page.dart';
import 'package:transport_guidance_user/providers/adminProvider.dart';
import 'package:transport_guidance_user/providers/busProvider.dart';
import 'package:transport_guidance_user/providers/userProvider.dart';

import 'pages/dashboard_page.dart';
import 'pages/profile_page.dart';
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.data}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.subscribeToTopic('accept');
  await FirebaseMessaging.instance.subscribeToTopic('deny');
  await FirebaseMessaging.instance.subscribeToTopic('noticed');
  await FirebaseMessaging.instance.subscribeToTopic('FCM_TOKEN_OF_SPECIFIC_ADMIN');
  print('FCM TOKEN $fcmToken');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>UserProvider()),
    ChangeNotifierProvider(create: (context)=>AdminProvider()),
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
        title: 'DIUBus',
        theme: ThemeData(
          textTheme: GoogleFonts.prataTextTheme(),
          primarySwatch: Colors.blueGrey,
      ),      builder: EasyLoading.init(),
    initialRoute: LauncherPage.routeName,
    routes: {
      LauncherPage.routeName:(_)=>const LauncherPage(),

      DashboardPage.routeName:(_)=>const DashboardPage(),
      AlternativePage.routeName:(_)=> AlternativePage(),
      FeedbackPage.routeName:(_)=>const FeedbackPage(),
      TicketsPage.routeName:(_)=>const TicketsPage(),
      LoginPage.routeName:(_)=> LoginPage(),
      NoticePage.routeName:(_)=>const NoticePage(),
      NotificationPage.routeName:(_)=>const NotificationPage(),
      ProfilePage.routeName:(_)=>const ProfilePage(),
      RegisterPage.routeName:(_)=> RegisterPage(),
      RequestPage.routeName:(_)=> RequestPage(),
      RoutePage.routeName:(_)=> RoutePage(),
      QusenAnsPage.routeName:(_)=> QusenAnsPage(),
      BusDetails.routeName:(_)=> BusDetails(),
    }
    );
  }
}
