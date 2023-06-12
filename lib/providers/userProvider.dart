import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:transport_guidance_user/database/database.dart';
import 'package:transport_guidance_user/models/userModel.dart';

import '../authservice/authentication.dart';

class UserProvider extends ChangeNotifier{
UserModel? userModel;
Future<void> addUser(UserModel userModel) {
  return dbhelper.addUser(userModel);
}
getUserInfo(){
  dbhelper.getUserInfo(AuthService.currentUser!.uid).listen((snapshot) {
    if(snapshot.exists){
      userModel=UserModel.fromMap(snapshot.data()!);
      notifyListeners();
    }
  });
}
Future<void>updateUserField( String felid, dynamic value){
  return dbhelper.updateUserField(AuthService.currentUser!.uid, {felid:value});
}

Future<String> uploadImage(String? thumbnailImageLocalPath)async {
  final photoRef= FirebaseStorage.instance.ref().child('users/${DateTime.now().microsecondsSinceEpoch}');
  final uploadTask=photoRef.putFile(File(thumbnailImageLocalPath!));
  final snapshot= await uploadTask.whenComplete(() => const Text('Upload Sucessfully'));
  return snapshot.ref.getDownloadURL();
}
}