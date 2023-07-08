
const String collectionMessage = 'Messages';
const String messageFielduserIDFrom = 'startTime';
const String messageFielduserIDto = 'from';
const String messageFieldtimestamp = 'destination';
const String messageFieldContent = 'bus type';
const String messageFieldtype = 'passenger type';
class MessageModel{

  String idFrom;
  String idTo;
  String timeStamp;
  String content;
  int type;


  MessageModel(
      {

        required this.idFrom,

        required  this.idTo,
        required  this.timeStamp,
        required this.content,
        required this.type});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{

      messageFielduserIDFrom: idFrom,

      messageFielduserIDto: idTo,
      messageFieldtimestamp: timeStamp,
      messageFieldContent: content,
      messageFieldtype: type,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
    idFrom: map[messageFielduserIDFrom],

    idTo: map[messageFielduserIDto],
    timeStamp: map[messageFieldtimestamp],
    content: map[messageFieldContent],
    type: map[messageFieldtype],
  );
}