import 'package:flutter/material.dart';
class SettingsPage extends StatelessWidget {
  static const String routeName ='/stg';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Setting'),),);
  }
}