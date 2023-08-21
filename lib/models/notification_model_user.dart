


import 'message_model.dart';
import 'notice_model.dart';
import 'reqModel.dart';

const String collectionNotificationUser = 'NotificationUser';

const String notificationFieldId = 'notificationId';
const String notificationFieldType = 'type';
const String notificationFieldMessage = 'message';
const String notificationFielduserStatus = 'status';
const String notificationuserFieldDate = 'Date';
const String notificationFieldComment = 'Notice';
const String notificationFieldUser = 'Message';
const String notificationFieldOrder = 'request';

class NotificationUSerModel {
  String? id;
  String type;
  String message;
  bool status;
  NoticeModel? noticeModel;
  MessageModel? msgModel;
  RequestModel? reqModel;
  String date;

  NotificationUSerModel({
    this.id,
    required this.date,
    required this.type,
    required this.message,
    this.status = false,
    this.noticeModel,
    this.msgModel,
    this.reqModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      notificationFieldId: id,
      notificationFieldType: type,
      notificationFieldMessage: message,
      notificationFielduserStatus: status,
      notificationuserFieldDate: date,
      // notificationFieldComment: noticeModel?.toMap(),
      notificationFieldUser: msgModel?.toMap(),
      notificationFieldOrder: reqModel?.toMap(),
    };
  }

  factory NotificationUSerModel.fromMap(Map<String, dynamic> map) =>
      NotificationUSerModel(
        id: map[notificationFieldId],
        type: map[notificationFieldType],
        message: map[notificationFieldMessage],
        status: map[notificationFielduserStatus],
        date: map[notificationuserFieldDate],
        // noticeModel: map[notificationFieldComment] == null
        //     ? null
        //     : NoticeModel.fromMap(map[notificationFieldComment]),
        msgModel: map[notificationFieldUser] == null
            ? null
            : MessageModel.fromMap(map[notificationFieldUser]),
        reqModel: map[notificationFieldOrder] == null
            ? null
            : RequestModel.fromMap(map[notificationFieldOrder]),
      );
}
