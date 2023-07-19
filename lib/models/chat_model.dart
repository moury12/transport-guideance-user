import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transport_guidance_user/models/admin_model.dart';
import 'package:transport_guidance_user/models/userModel.dart';
const String collectionchat = 'Chat';

class ChatMessage {
  UserModel sender; // The sender of the message (admin or user)
  AdminModel receiver; // The receiver of the message (admin or user)
  String content; // The content of the message
  DateTime timestamp; // Timestamp when the message is sent

  ChatMessage({
    required this.sender,
    required this.receiver,
    required this.content,
    required this.timestamp,
  });

  ChatMessage.fromMap(Map<String, dynamic> map)
      : sender = UserModel.fromMap(map["sender"]), // Provide a default value when sender is null
        receiver = AdminModel.fromMap(map["receiver"]),// Provide a default value when receiver is null
        content = map['content'] ?? '',
        timestamp = (map['timestamp'] as Timestamp).toDate();

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'receiver': receiver,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
