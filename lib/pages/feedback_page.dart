import 'package:flutter/material.dart';
class FeedbackPage extends StatelessWidget {
  static const String routeName ='/feed';
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('FeedBack'),),);
  }
}