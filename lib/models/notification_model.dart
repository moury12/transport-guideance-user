





import 'package:transport_guidance_user/models/message_model.dart';

import 'feedback_model.dart';
import 'reqModel.dart';
import 'userModel.dart';

const String collectionNotification = 'Notifications';

const String notificationFieldId = 'notificationId';
const String notificationFieldType = 'type';
const String notificationFieldMessage = 'Message';
const String notificationFieldStatus = 'status';
const String notificationFieldDate = 'Date';
const String notificationFieldComment = 'feedback';
const String notificationFieldUser = 'user';
const String notificationFieldOrder = 'request';
const String notificationFieldmsg = 'Messages';

class NotificationModel {
  String id;
  String type;
  String message;
  bool status;
  FeedbackModel? feedbackModel;
  UserModel? userModel;
  RequestModel? reqModel;
  MessageModel? msgModel;
  String? date;


  NotificationModel(
      {required this.id,
        required this.type,
        required this.message,
        required this.status,
      this.feedbackModel,
      this.userModel,
      this.reqModel,
      this.msgModel,
      this.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      notificationFieldId: id,
      notificationFieldType: type,
      notificationFieldMessage: message,
      notificationFieldStatus: status,
      notificationFieldDate: date,
      notificationFieldComment: feedbackModel?.toMap(),
      notificationFieldUser: userModel?.toMap(),
      notificationFieldOrder: reqModel?.toMap(),
      notificationFieldmsg: msgModel?.toMap(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) =>
      NotificationModel(
        id: map[notificationFieldId],
        type: map[notificationFieldType],
        message: map[notificationFieldMessage],
        status: map[notificationFieldStatus],
        date: map[notificationFieldDate],
        feedbackModel: map[notificationFieldComment] == null
            ? null
            : FeedbackModel.fromMap(map[notificationFieldComment]),
        userModel: map[notificationFieldUser] == null
            ? null
            : UserModel.fromMap(map[notificationFieldUser]),
        reqModel: map[notificationFieldOrder] == null
            ? null
            : RequestModel.fromMap(map[notificationFieldOrder]),
        msgModel: map[notificationFieldmsg] == null
            ? null
            : MessageModel.fromMap(map[notificationFieldmsg]),
      );
}
