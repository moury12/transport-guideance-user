import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transport_guidance_user/database/database.dart';
import 'package:transport_guidance_user/models/admin_model.dart';

import '../models/message_model.dart';

class AdminProvider extends ChangeNotifier {
  AdminModel? userModel;
  List<AdminModel> userList = [];
  List<MessageModel> message = [];
  Map<String, MessageModel> _lastMessages =
      {}; // Map to store the last message for each user
  Map<String, int> _unreadMessageCount =
      {}; // Map to store the count of unread messages for each user

  List<AdminModel> get _userList => userList;

  // Method to update last message for a user
  void updateLastMessage(String userId, MessageModel message) {
    _lastMessages[userId] = message;
    notifyListeners();
  }

  // Method to get the last message for a user
  MessageModel? getLastMessageForUser(String userId) {
    return _lastMessages[userId];
  }

  getAdminInfo() {
    dbhelper.getAdminInfo().listen((snapshot) {
      userList = List.generate(snapshot.docs.length,
          (index) => AdminModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
  // Method to update unread message count for a user

  void updateUnreadMessageCount(String userId, int count) {
    _unreadMessageCount[userId] = count;
    notifyListeners();
  }

  // Method to get the count of unread messages for a user
  int getUnreadMessagesCountForUser(String userId) {
    return _unreadMessageCount[userId] ?? 0;
  }

  bool hasUnreadMessagesForUser(String userId) {
    final unreadCount = _unreadMessageCount[userId] ?? 0;
    return unreadCount > 0;
  }

  // Method to get the last message for a specific user

  // Method to update the last message for a specific user
  void updateLastMessageForUser(String userId, MessageModel message) {
    _lastMessages[userId] = message;
    notifyListeners();
  }

  List<MessageModel> getMessagesFromUser(String userId) {
    return _lastMessages.values
        .where((message) => message.idFrom == userId)
        .toList();
  }

  // Method to mark messages as read for a specific user
  void markMessagesAsReadForUser(String userId) {
    final messages = getMessagesFromUser(userId);
    for (final message in messages) {
      if (!message.isRead) {
        message.isRead = true;
        // Update the message in Firestore with the new isRead status
        FirebaseFirestore.instance
            .collection(collectionMessage)
            .doc(message.messageId)
            .update({'isRead': true});
      }
    }
  }

  Future<AdminModel> getAdminById(String id) async {
    final snapshot = await dbhelper.getAdminById(id);
    return AdminModel.fromMap(snapshot.data()!);
  }
}
