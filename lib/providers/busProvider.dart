import 'package:flutter/material.dart';
import 'package:transport_guidance_user/database/database.dart';

import '../models/busModel.dart';
import '../models/schedule_model.dart';

class BusProvider extends ChangeNotifier{
  List<BusModel> busList=[];
  List<ScheduleModel>scheduleList=[];
  getAllBus(){
    dbhelper.getAllBus().listen((snapshot) {
      busList=List.generate(snapshot.docs.length, (index) => BusModel.fromMap(snapshot.docs[index].data()));
      busList.sort((cat1, cat2)=>cat1.busName.compareTo(cat2.busName));
      notifyListeners();
    });
  }
  getAllSchedule(){
    dbhelper.getAllSchedule().listen((snapshot) {
      scheduleList=List.generate(snapshot.docs.length, (index) => ScheduleModel.fromMap(snapshot.docs[index].data()));

      notifyListeners();
    });
  }

  void getBusListbyFrom(String? city,String city1) {
    dbhelper.getBusListbyFrom(city).listen((snapshot) {
      scheduleList=List.generate(snapshot.docs.length, (index) =>
          ScheduleModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  void getBusListbyroute(String? city, String? city1, String startTime) {
    dbhelper.getBusListbyroute(city,city1,startTime).listen((snapshot){
      scheduleList= List.generate(snapshot.docs.length ,(index)=>
          ScheduleModel.fromMap(snapshot.docs[index].data())
      );
    });
  }
}