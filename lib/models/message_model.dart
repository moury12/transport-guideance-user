
import 'package:cloud_firestore/cloud_firestore.dart';

const String collectionMessage = 'Messages';
const String messageFielduserIDFrom = 'sender';
const String messageFielduserIDto = 'receiver';
const String messageFieldtimestamp = 'timestamp';
const String messageFieldContent = 'content';

class MessageModel{

  String idFrom;
  String idTo;
  DateTime timeStamp;
  String content;



  MessageModel(
      {

        required this.idFrom,

        required  this.idTo,
        required  this.timeStamp,
        required this.content,
        });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{

      messageFielduserIDFrom: idFrom,

      messageFielduserIDto: idTo,
      messageFieldtimestamp: Timestamp.fromDate(timeStamp),
      messageFieldContent: content,

    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
    idFrom: map[messageFielduserIDFrom],

    idTo: map[messageFielduserIDto],
    timeStamp: (map[messageFieldtimestamp]as Timestamp).toDate(),
    content: map[messageFieldContent],
  );
}