import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/providers/busProvider.dart';

import '../constant/utils.dart';
class TicketsPage extends StatefulWidget {
  static const String routeName ='/ticket';
  const TicketsPage({Key? key}) : super(key: key);

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {@override

  @override
  Widget build(BuildContext context) {
  final bus = Provider.of<BusProvider>(context);

  return Scaffold(appBar:
  AppBar(foregroundColor: Colors.black54,
      title: Row(
        children: [
          Image.asset(
            'assets/logo2.png',
            height: 70,
            width: 70,
          ),
          Center(
              child: Text('Tickets ',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 15))),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      child: Container(
        child: Consumer<BusProvider>(
          builder: (context, provider, child) {
            final itemList=provider.ticketitem;
            return ExpansionPanelList(expansionCallback:(index, isExpanded) {
              setState(() {
                itemList[index].isExpanded=!isExpanded;
              });
            },
              children: itemList.map<ExpansionPanel>((orderItem) => ExpansionPanel(
                  isExpanded: orderItem.isExpanded,
                  headerBuilder: (context, isExpanded) =>
                      ListTile(
                        title: Text(orderItem.ticketUserModel.date,
                        ),

                      ), body:
              Column(
                children:[]
              )
              )).toList(),);
          },
        ),
      ),
    ),
  );
  }
}