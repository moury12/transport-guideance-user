import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport_guidance_user/models/message_model.dart';
import 'package:transport_guidance_user/models/userModel.dart';

class MessageProvider extends ChangeNotifier{
final SharedPreferences preferences;
final FirebaseFirestore firebaseFirestore;
final FirebaseStorage firebaseStorage;

MessageProvider(
      {
        required this.preferences,required this.firebaseFirestore,required this.firebaseStorage});
UploadTask uploadTask (File img, String filename){
  Reference reference =firebaseStorage.ref().child(filename);
  UploadTask uploadTask = reference.putFile(img);
  return uploadTask;
}
Future<void> updateDataFireStore(String collectionPath ,String docPath , Map<String, dynamic> dataneededUpdate
    ){
  return firebaseFirestore.collection(collectionPath).doc(docPath).update(dataneededUpdate);
}
Stream<QuerySnapshot> getChatStream (String groupChatId, int limit){
  return firebaseFirestore
      .collection(collectionUser).doc(groupChatId).collection(groupChatId).orderBy(messageFieldtimestamp, descending: true).limit(limit).snapshots();
}
void SendMessage(String content, int type, String groupChatId, String currentUserId, String peerId){
  DocumentReference documentReference = firebaseFirestore.collection(collectionMessage).doc(groupChatId)
      .collection(groupChatId).doc(DateTime.now().millisecondsSinceEpoch.toString());
  MessageModel messageModel =MessageModel(
      idFrom: currentUserId, idTo: peerId,
      timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content, type: type);
  FirebaseFirestore.instance.runTransaction((transaction) async{
    transaction.set(documentReference, messageModel.toMap());
  });
}
}