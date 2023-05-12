import 'package:flutter/material.dart';
class AlternativePage extends StatelessWidget {
  static const String routeName ='/altpath';
  const AlternativePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('AltPath'),),);
  }
}