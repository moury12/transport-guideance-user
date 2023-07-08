import 'package:flutter/material.dart';
import 'package:transport_guidance_user/database/database.dart';
import 'package:transport_guidance_user/models/admin_model.dart';

class AdminPtovider extends ChangeNotifier{

  AdminModel? userModel;
  List<AdminModel> userList = [];
   getAdminInfo() {
     dbhelper.getAdminInfo().listen((snapshot) {
      userList = List.generate(snapshot.docs.length,
              (index) => AdminModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
   }
}