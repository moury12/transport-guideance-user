import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return
    Stack(
      children: [

        Card(elevation: 5,
        child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [IconButton(onPressed: () {
              Navigator.pushNamed(context, DashboardPage.routeName);
            },
               icon:             Icon(Icons.cancel_rounded,color: Colors.red.shade200,),
            ),
              IconButton(onPressed: () async{
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
              },                icon:             Icon(Icons.upload,color: Colors.red.shade200,),
                  ),

            ],
        ),
          )
,
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 38.0,right: 38.0,top: 38.0,bottom: 10),
                child:
        Card(clipBehavior: Clip.none,
              color: Colors.white,
                    elevation: 20,  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
style: GoogleFonts.actor(fontSize: 12),
                        maxLines: 3,
                        controller: txtcontroller,
                        decoration: InputDecoration( hintText: 'Post your Feedback ',
                            hintStyle: GoogleFonts.actor(fontSize: 12),
                            focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.transparent),),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0, color: Colors.transparent),)),
                        focusNode: focusNode,
                      ),
                    ),
                  ),

              ),
              Positioned(
                  bottom: 0,
                  left: 88,
                  child:Icon(Icons.circle,color: Colors.white,size: 35,)
              ),
            ],
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: CachedNetworkImage(fit: BoxFit.cover,
                height: 130,
                width: 130,
                imageUrl: userProvider.userModel?.imageUrl ?? '',
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                const Icon(Icons.account_circle),
        ),
              ),
              Positioned(
                  top: 6,
                  left: 5,
                  child:Icon(Icons.circle,color: Colors.white,size: 20,)
              ),
            ],
          ),



        ]
        ),),
        Positioned(bottom: 0,
          left: 0,
          right: 0,
          child: TextButton.icon(onPressed: () {

          },label: Text('Share with transport supervisor',style: GoogleFonts.actor(),),icon:Icon(Icons.account_circle,color: Colors.black54,size: 20,) ,),
        )
      ],
    );
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