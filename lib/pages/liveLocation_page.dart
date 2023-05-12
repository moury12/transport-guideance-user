import 'package:flutter/material.dart';
class LiveLocationPage extends StatelessWidget {
  static const String routeName ='/live';
  const LiveLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Live Location'),),);
  }
}