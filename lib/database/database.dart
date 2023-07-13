import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transport_guidance_user/models/admin_model.dart';
import 'package:transport_guidance_user/models/feedback_model.dart';
import 'package:transport_guidance_user/models/reqModel.dart';
import 'package:transport_guidance_user/models/schedule_model.dart';
import 'package:transport_guidance_user/models/userModel.dart';

import '../models/busModel.dart';
import '../models/notification_model.dart';

class dbhelper{
  static Future<void> addNotification(NotificationModel notificationModel) {
    return db.collection(collectionNotification).doc(notificationModel.id).set(notificationModel.toMap());
  }
  static Future<bool> doesUserExist(String uid) async {
    final snapshot = await db.collection(collectionUser).doc(uid).get();
    return snapshot.exists;
  }
  static final db =FirebaseFirestore.instance;
  static Future<void> addUser(UserModel userModel) {
    return db.collection(collectionUser).doc(userModel.userId).set(userModel.toMap());
  }
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String uid) =>
      db.collection(collectionUser).doc(uid).snapshots();

  static Future<void> updateUserField(String uid, Map<String, dynamic> map) {
    return db.collection(collectionUser).doc(uid).update(map);
  }
  static Stream<QuerySnapshot<Map<String,dynamic>>>getAllBus()=>
      db.collection(collectionBus).snapshots();
  static Stream<QuerySnapshot<Map<String,dynamic>>>getAllSchedule()=>
      db.collection(collectionSchedule).snapshots();



  static Stream<QuerySnapshot<Map<String,dynamic>>> getAdminInfo() =>
      db.collection(collectionAdmin).snapshots();





  static Stream<QuerySnapshot<Map<String,dynamic>>> getBusListbyroute(String? city,
      String? city1, String startTime) =>
      db.collection(collectionSchedule).where('$scheduleFieldfrom' ,isEqualTo: city ).
      where('$scheduleFielddestination' ,isEqualTo: city1)
          .where('$scheduleFieldstartTime', isEqualTo: startTime)
          .snapshots();
  static Future<void>addRequestBus(RequestModel requestBus) {
    return db.collection(collectionRequest).doc(requestBus.reqId).set(requestBus.toMap());

  }

  static Future<void> addComment(FeedbackModel commentmodel) async {
    return db
        .collection(collectionComment)


        .doc(commentmodel.commentId)
        .set(commentmodel.toMap());
  }
}