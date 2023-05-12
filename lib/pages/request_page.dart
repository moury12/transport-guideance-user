import 'package:flutter/material.dart';
class RequestPage extends StatelessWidget {
  static const String routeName ='/req';
  const RequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Request'),),);
  }
}