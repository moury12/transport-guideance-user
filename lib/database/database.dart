import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transport_guidance_user/models/schedule_model.dart';
import 'package:transport_guidance_user/models/userModel.dart';

import '../models/busModel.dart';

class dbhelper{
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



  static Stream<QuerySnapshot<Map<String,dynamic>>>getBusListbyFrom(String? city)=>
      db.collection(collectionSchedule).where('$scheduleFieldfrom' ,isEqualTo: city).snapshots();






  static Stream<QuerySnapshot<Map<String,dynamic>>> getBusListbyroute(String? city,
      String? city1, String startTime) =>
      db.collection(collectionSchedule).where('$scheduleFieldfrom' ,isEqualTo: city ).
      where('$scheduleFielddestination' ,isEqualTo: city1)

      //.where('$scheduleFieldstartTime', isEqualTo: startTime)
          .snapshots();

}