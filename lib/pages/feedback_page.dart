import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/models/feedback_model.dart';
import 'package:intl/intl.dart';
import 'package:transport_guidance_user/models/userModel.dart';
import 'package:transport_guidance_user/pages/dashboard_page.dart';
import 'package:transport_guidance_user/providers/busProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constant/utils.dart';
import '../models/notification_model.dart';
import '../providers/userProvider.dart';
class FeedbackPage extends StatefulWidget {
  static const String routeName ='/feed';
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final txtcontroller =TextEditingController();
  late BusProvider busProvider;
  late UserModel userModel;
  final focusNode =FocusNode();
  @override
  void didChangeDependencies() {
    busProvider = Provider.of<BusProvider>(context, listen: false);


    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(appBar: AppBar(backgroundColor: Colors.white,foregroundColor: Colors.black54,elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/logo2.png',height: 50,width: 50,),
            Text('Feedback',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
          ],
        )),
    body: Card(elevation: 5,
    child: Column(
    children: [Image.asset(
      'assets/i2.png', height: 142, width: 142,),

    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text('Post your Feedback ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontSize: 14),),
    ),
    TextField(
    maxLines: 3,
    controller: txtcontroller,
    decoration: InputDecoration(border: OutlineInputBorder()),
    focusNode: focusNode,
    ),
    OutlinedButton(onPressed: () async{
    if(txtcontroller.text.isEmpty){
    showMsg(context, 'Please! provide a valid feedback');
    return;
    }

    EasyLoading.show(status: 'please wait');
    final commentModel= FeedbackModel(
        commentId: DateTime.now().microsecondsSinceEpoch.toString(),
        userModel: context.read<UserProvider>().userModel!,
    comment: txtcontroller.text,
        date:getFormattedDate(DateTime.now(),pattern: 'dd/MM/yyyy')
    );
    await busProvider.addComment(commentModel);
    EasyLoading.dismiss();
    focusNode.unfocus();
    txtcontroller.clear();
    showMsg(context, 'Thanks for your feedback, your feedback is waiting for admin read');
    Navigator.pushNamed(context, DashboardPage.routeName);
    final notificationModel =NotificationModel(id: DateTime.now().microsecondsSinceEpoch.toString(),
        type: NotificationType.comment,status: false,
        message: 'User ${commentModel.userModel.name} has  post a feedback which is waiting for admin feedback',feedbackModel:commentModel );
    await Provider.of<BusProvider>(context,listen: false).addNotification(notificationModel);
    _notifyUser(commentModel);
    }, child: Text('Submit'),style: ButtonStyle(foregroundColor: MaterialStatePropertyAll<Color>(Colors.pinkAccent)),)
    ]
    ),),);
  }
  void _notifyUser(FeedbackModel feedbackModel) async {
    final url = 'https://fcm.googleapis.com/fcm/send';
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };
    final body = {
      "to": "/topics/feedback",
      "notification": {
        "title": "A New Feedback posted by ${feedbackModel.userModel.email} ",
        "body": "${feedbackModel.comment}\n${feedbackModel.userModel.versityId??''} "
      },
      "data": {"key": "feed", "value": feedbackModel.date}
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: json.encode(body),
      );

    } catch (error) {
      print(error.toString());
    }
  }
  getFormattedDate(DateTime dt, {String pattern = 'dd/MM/yyyy'}) =>
      DateFormat(pattern).format(dt);
}