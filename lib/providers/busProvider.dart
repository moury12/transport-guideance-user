import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:transport_guidance_user/database/database.dart';
import 'package:transport_guidance_user/models/feedback_model.dart';
import 'package:transport_guidance_user/models/notice_model.dart';
import 'package:transport_guidance_user/models/notification_model_user.dart';
import 'package:transport_guidance_user/models/reqModel.dart';
import 'package:transport_guidance_user/models/ticket_model.dart';
import 'package:transport_guidance_user/models/user_ticket_model.dart';

import '../authservice/authentication.dart';
import '../models/busModel.dart';
import '../models/notification_model.dart';
import '../models/schedule_model.dart';

class BusProvider extends ChangeNotifier {
  List<BusModel> busList = [];
  List<ScheduleModel> scheduleList = [];
  List<ScheduleModel> filterScheduleList = [];
  List<NoticeModel> notice = [];
  List<TicketModel> tickets=[];
  List<TicketUserModel> usersTicket=[];
  List<TicketItem> ticketitem=[];
  List<NotificationUSerModel> notuser = [];
  Future<RequestModel> getProductById(String id) async {
    final snapshot = await dbhelper.getreqById(id);
    return RequestModel.fromMap(snapshot.data()!);
  }
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


  getAllNotification(){
    dbhelper.getAllNotification().listen((snapshot) {
      notuser=List.generate(snapshot.docs.length, (index) => NotificationUSerModel.fromMap(snapshot.docs[index].data()));

      notifyListeners();
    });
  }
  getAllNotice(){
    dbhelper.getAllNotice().listen((snapshot) {
      notice=List.generate(snapshot.docs.length, (index) => NoticeModel.fromMap(snapshot.docs[index].data()));

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
  Future<void> deleteRequestById(String? reqId) async{
    await dbhelper.deleteRequestById(reqId);
  }
  Future<void> deletenotificationUserById(String? id) async{
    await dbhelper.deletenotificationUserById(id);
  }
  Future<void> updateNotificationStatus(String notId, bool status)async {
    dbhelper.updateNotificationStatus(notId,status);
  }
  Future<List<TicketModel>> getallTickets(String? id)async{
    final snapshot = await dbhelper.getallTicketsbySchedule(id!);

    return List.generate(snapshot.docs.length, (index) => TicketModel.fromMap(snapshot.docs[index].data()));
  }
  Future<void> addTickets(TicketModel ticket) async{
    await dbhelper.addTickets(ticket);
  }

  Future<void> addUserTicket(TicketUserModel userTicket) async{
return dbhelper.addUserTicket(userTicket);
  }
  getAllticketByUser() {
    dbhelper.getAllticketByUser(AuthService.currentUser!.uid).listen((snapshot) {
      usersTicket = List.generate(snapshot.docs.length,
              (index) => TicketUserModel.fromMap(snapshot.docs[index].data()));
      ticketitem=usersTicket.map((order) => TicketItem(ticketUserModel: order)).toList();
      notifyListeners();
    });
  }
}
