import 'package:flutter/material.dart';
class RoutePage extends StatelessWidget {
  static const String routeName ='/routes';
  const RoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Routes'),),);
  }
}