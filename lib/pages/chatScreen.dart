import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/models/admin_model.dart';
import 'package:transport_guidance_user/models/userModel.dart';
import 'package:transport_guidance_user/models/message_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constant/utils.dart';
import '../models/notification_model.dart';
import '../providers/adminProvider.dart';

class ChatScreen extends StatefulWidget {
  final AdminModel admin;
  final UserModel user;

  ChatScreen({required this.admin, required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final CollectionReference _messagesCollection =
      FirebaseFirestore.instance.collection(collectionMessage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(180),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.red.shade200,
                  size: 40,
                )),
          ),
          title: Text(
            widget.admin.name,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            maxLines: 1,
          )),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesCollection
                  .where('sender',
                      whereIn: [widget.user.userId, widget.admin.adminId])
                  .orderBy(messageFieldtimestamp, descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs;
                  // Filter messages for receiver (idTo) in Dart code
                  final filteredMessages = messages.where((message) {
                    final messageData = message.data() as Map<String, dynamic>;
                    final receiverId = messageData['receiver'] as String;
                    return receiverId == widget.user.userId ||
                        receiverId == widget.admin.adminId;
                  }).toList();
                  return ListView.builder(
                    reverse: true,
                    itemCount: filteredMessages.length,
                    itemBuilder: (context, index) {
                      final message = MessageModel.fromMap(
                          filteredMessages[index].data()
                              as Map<String, dynamic>);
                      return _buildMessage(message);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessage(MessageModel message) {
    final isSender = message.idFrom == widget.user.userId;
    final messageAlignment =
        isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final messagemAlignment =
        isSender ? MainAxisAlignment.start : MainAxisAlignment.end;
    final messageColor =
        isSender ? Colors.lightBlue.shade100 : Colors.red.shade100;
    final messageTextColor = isSender ? Colors.black87 : Colors.black87;
    final isRead = message.isRead;
    if (!isSender) {
      final userId = message.idTo;
      Provider.of<AdminProvider>(context, listen: false)
          .updateLastMessageForUser(userId, message);
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: messageAlignment,
        children: [
          Card(
            color: messageColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                message.content,
                style: TextStyle(color: messageTextColor, fontSize: 10),
              ),
            ),
          ),
          SizedBox(height: 4),
          SizedBox(
            width: 100,
            child: Text(
              maxLines: 1,
              message.timeStamp.toLocal().toString(),
              style: TextStyle(fontSize: 8, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.black54, fontSize: 10),
              controller: _textEditingController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.lightBlueAccent, width: 0.5)),
                  hintText: 'Type your message...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.lightBlueAccent, width: 0.5)),
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 10)),
              onSubmitted: _handleSubmitted,
            ),
          ),
          FloatingActionButton.small(
            backgroundColor: Colors.redAccent.shade100,
            child: Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textEditingController.text),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) async {
    if (
    text.isNotEmpty) {
      final newMessage = MessageModel(
        isRead: false,
        messageId: DateTime.now().millisecondsSinceEpoch.toString(),
        idFrom: widget.user.userId,
        idTo: widget.admin.adminId,
        timeStamp: DateTime.now(),
        content: text,
      );
      //showMsg(context, "Sent Request to the Admin");

      // showMsg(context, 'Thanks for your feedback, your feedback is waiting for admin read');

      //Navigator.pushReplacementNamed(context, DashboardPage.routeName);
      _messagesCollection.add(newMessage.toMap());
      final notificationModel = NotificationModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          status: false,
          type: NotificationType.order,
          message: 'A new message from ${widget.user.name}',
          msgModel: newMessage);
      //await Provider.of<BusProvider>(context,listen: false).addNotification(notificationModel);
      _notifyUser(newMessage, widget.admin.adminToken);
      Provider.of<AdminProvider>(context, listen: false)
          .updateLastMessageForUser(widget.admin.adminId, newMessage);

      // Increase the unread message count for the admin user
      Provider.of<AdminProvider>(context, listen: false)
          .updateUnreadMessageCount(widget.admin.adminId, 1);
      _textEditingController.clear();
    } else {
      showMsg(context, "Please! provide any text");
    }
  }

  void _notifyUser(MessageModel msg, String? adminToken) async {
    final url = 'https://fcm.googleapis.com/fcm/send';
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };
    final body = {
      "to": adminToken,
      "notification": {
        "title": "A New message from ${widget.user.name} ",
        "body": """${msg.content}"""
      },
      "data": {"key": "msg", "value": widget.user.userId}
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
}
