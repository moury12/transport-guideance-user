import 'package:flutter/material.dart';
class TicketPage extends StatelessWidget {
  static const String routeName ='/tic';
  const TicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Ticket'),),);
  }
}