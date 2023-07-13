import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:transport_guidance_user/database/database.dart';
import 'package:transport_guidance_user/models/feedback_model.dart';
import 'package:transport_guidance_user/models/reqModel.dart';

import '../models/busModel.dart';
import '../models/notification_model.dart';
import '../models/schedule_model.dart';

class BusProvider extends ChangeNotifier {
  List<BusModel> busList = [];
  List<ScheduleModel> scheduleList = [];
  List<ScheduleModel> filterScheduleList = [];
  getAllBus() {
    dbhelper.getAllBus().listen((snapshot) {
      busList = List.generate(snapshot.docs.length,
              (index) => BusModel.fromMap(snapshot.docs[index].data()));
      busList.sort((cat1, cat2) => cat1.busName.compareTo(cat2.busName));
      notifyListeners();
    });
  }
  Future<void> addComment(FeedbackModel commentModel) async {

    return dbhelper.addComment(commentModel);
  }
  Future<void> addNotification(NotificationModel notificationModel) {
    return dbhelper.addNotification(notificationModel);
  }
  getAllSchedule() {
    dbhelper.getAllSchedule().listen((snapshot) {
      scheduleList = List.generate(snapshot.docs.length,
              (index) => ScheduleModel.fromMap(snapshot.docs[index].data()));
      filterScheduleList = scheduleList;
      notifyListeners();
    });
  }



  void getBusListbyroute(
      String? city, String? city1, TimeOfDay? startTime, BuildContext context) {
    log(" city: ${city}---- ${startTime}");
    // log(" CHEKC: ${scheduleList[1].destination.trim().toString() == city}----");
    filterScheduleList = city1 == null && startTime == null
        ? scheduleList
        .where((element) => element.destination.trim().toString() == city)
        .toList()
        : startTime == null
        ? scheduleList
        .where((element) =>
    element.destination.trim().toString() == city &&
        element.from.trim().toString() == city1)
        .toList()
        : scheduleList
        .where((element) =>
    element.destination.trim().toString() == city &&
        element.from.trim().toString() == city1 &&
        element.startTime.trim().toString() ==
            startTime.format(context).toString())
        .toList();
    notifyListeners();
    log(filterScheduleList.length.toString());
  }
  Future<void> addRequestBus(RequestModel requestBus) {
    return dbhelper.addRequestBus(requestBus);
  }

}
