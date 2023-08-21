import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/constant/utils.dart';
import 'package:transport_guidance_user/models/notice_model.dart';
import 'package:transport_guidance_user/models/notification_model_user.dart';
import 'package:transport_guidance_user/models/userModel.dart';
import 'package:transport_guidance_user/pages/home_page.dart';
import 'package:transport_guidance_user/pages/notice_page.dart';
import 'package:transport_guidance_user/pages/qusen_ans_page.dart';

import '../authservice/authentication.dart';
import '../providers/busProvider.dart';

class NotificationPage extends StatefulWidget {
  static const String routeName = '/not';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late BusProvider busprovider;
  @override
  void didChangeDependencies() {
    busprovider = Provider.of<BusProvider>(context, listen: false);
    // requestModel = ModalRoute.of(context)!.settings.arguments as RequestModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          leading: Image.asset(
            'assets/logo2.png',
            height: 40,
            width: 40,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
          elevation: 0,
          title: Text(
            'Notifications',
            style:   GoogleFonts.bentham(),
          )),
body: Consumer<BusProvider>(
  builder: (context, provider, child) => ListView.builder(
    itemCount: provider.notuser.length,
    itemBuilder: (context, index) {
      final notification = provider.notuser[index];
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            leading: notification.type=='New Notice'?
            Icon(Icons.note_alt_rounded,color: Colors.lightBlue.shade200,)
                :notification.type=='Accept Request'?
            Icon(Icons.mark_email_read,color: Colors.deepPurpleAccent.shade100,)
                :notification.type=='New Message'?
            Icon(Icons.message_outlined,color:Colors.red.shade200)
                :Icon(Icons.error,color: Colors.teal.shade200,),
            tileColor:
            notification.status ? null : Colors.white,
            onTap: () {
              _navigate(context, notification, provider);
            },
            title: Text(notification.type,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.message,maxLines:2,style: TextStyle(color: Colors.black54,fontSize: 10),),
                Text(notification.date??'',style: TextStyle(color: Colors.blue,fontSize: 10),),

              ],
            ),
          ),
        ),
      );
    },
  ),
),
    );
  }
  void _navigate(BuildContext context, NotificationUSerModel notification,
      BusProvider provider) {
    String routeName = '';
    dynamic id = '';
    switch (notification.type) {
      case NotificationuserType.request:
        id = notification.reqModel!.reqId;
        routeName =HomePage.routeName;
       // busprovider.deleteRequestById(id);
        break;
      case NotificationuserType.Notice:
        id = notification.noticeModel!.noticeId;
routeName =NoticePage.routeName;
        //_showCustomDialog(context, id,notification.noticeModel);

        break;
      case NotificationuserType.message:
        id = notification.msgModel!.messageId;
        routeName =QusenAnsPage.routeName;
        break;
      case NotificationuserType.deny:
        id = notification.reqModel!.reqId;
       // busprovider.deleteRequestById(id);
       // busprovider.deletenotificationUserById(id);
        break;
    }
    provider.updateNotificationStatus(notification.id!, notification.status);
    Navigator.pushNamed(context, routeName, arguments: id);
  }

  void _showCustomDialog(BuildContext context, id, NoticeModel? noticeModel) {showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dialog Title'),
          content: Column(
            children: [
              Text(noticeModel!.Noticetitle),
              Text(noticeModel.message,maxLines: 5,),
            ],
          ),
          actions: [
            FloatingActionButton.small(
              child: Icon(Icons.check),
              onPressed: () {
                // Perform action for Button 1
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            FloatingActionButton.small(
              child: Icon(Icons.cancel),
              onPressed: () {
                // Perform action for Button 2
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

}
