import 'package:flutter/material.dart';

import '../constant/utils.dart';
class RoutePage extends StatefulWidget {
  static const String routeName ='/routes';
  const RoutePage({Key? key}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  String? city;
  String? city1;
  TimeOfDay startTime=TimeOfDay(hour:00 , minute: 00);
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        backgroundColor: Colors.white,foregroundColor: Colors.black54,elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/logo2.png',height: 50,width: 50,),
            Text('Select Route',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
          ],
        )),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DropdownButton<String>(
              value: city,
              hint: Text('From',style: TextStyle(color: Colors.black54),),
              isExpanded: true,
              items: subDistricts
                  .map((city) => DropdownMenuItem<String>(
                  value: city, child: Text(city)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  city = value;
                });
              }),
        ), Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              DropdownButton<String>(
                  value: city1,
                  hint: Text('To'),
                  isExpanded: true,
                  items: subDistricts
                      .map((city) => DropdownMenuItem<String>(
                      value: city, child: Text(city)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      city1 = value;
                    });
                  }),

        ),
        TextButton.icon(onPressed: selectstarttime, icon: Icon(Icons.schedule), label: Text( startTime.hour==0 ?'Select Time':startTime!.format(context).toString())),
        FloatingActionButton(
          onPressed:_findbus,
          child: Icon(
            Icons.arrow_forward_outlined,
            size: 30,
            color: Colors.white,
          ),
          backgroundColor: Colors.teal.shade200,
        ),
      ],
    ),);
  }
  void selectstarttime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
      setState(() {
        startTime=value!;
      });
    });
  }

  void _findbus() {
  }
}