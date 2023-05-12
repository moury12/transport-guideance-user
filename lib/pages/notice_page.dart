import 'package:flutter/material.dart';
class NoticePage extends StatelessWidget {
  static const String routeName ='/notice';
  const NoticePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Notice'),),);
  }
}