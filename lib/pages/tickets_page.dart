import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/models/schedule_model.dart';

import '../models/busModel.dart';
import '../providers/busProvider.dart';

class TicketPage extends StatefulWidget {
  static const String routeName = '/tic';
  const TicketPage({Key? key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  late ScheduleModel scheduleModel;
  late BusProvider busprovider;
  BusModel? busModel;
  @override
  void didChangeDependencies() {
    busprovider = Provider.of<BusProvider>(context, listen: false);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black54,
          title: Row(
            children: [
              Image.asset(
                'assets/logo2.png',
                height: 70,
                width: 70,
              ),
              Center(
                  child: Text('Book Tickets',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 15))),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<BusProvider>(
                builder: (context, provider, child) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<BusModel>(
                      hint: const Text('Select Bus'),
                      value: busModel,
                      isExpanded: true,
                      validator: (value) {
                        if (value == null) {
                          return 'please select a Bus';
                        }
                        return null;
                      },
                      items: provider.busList
                          .map((busModel) => DropdownMenuItem(
                          value: busModel, child: Text(busModel.busName)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          busModel = value;
                        });
                      }),
                ),
              ),
            ),
Row(mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(Icons.square_rounded,color: Colors.pinkAccent,),
    ),Text('Booked',style: TextStyle(color: Colors.black54,fontSize: 10),),
    SizedBox(width: 70,),Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,),
    ),Text('Available',style: TextStyle(color: Colors.black54,fontSize: 10),)
  ],
),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
children: [
  Text('A'),
  SizedBox(width: 70,),

  Text('B'),
  SizedBox(width: 100,),
  Text('C'),
  SizedBox(width: 70,),

  Text('D'),
],

),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
children: [
  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),
  SizedBox(width: 30,),

  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

  SizedBox(width: 58,),
  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),


  SizedBox(width: 30,),

  IconButton(icon: Icon(Icons.square_rounded,color: Colors.pinkAccent,size: 50,),onPressed: (){},),

],

),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
children: [
  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

  SizedBox(width: 30,),

  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

  SizedBox(width: 58,),
  IconButton(icon: Icon(Icons.square_rounded,color: Colors.pinkAccent,size: 50,),onPressed: (){},),

  SizedBox(width: 30,),

  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

],

),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
children: [
  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),
  SizedBox(width: 30,),

  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

  SizedBox(width: 58,),
  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

  SizedBox(width: 30,),

  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

],

),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
children: [
  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),
  SizedBox(width: 30,),

  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

  SizedBox(width: 58,),
  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

  SizedBox(width: 30,),

  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

],

),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
children: [
  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),
  SizedBox(width: 30,),

  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

  SizedBox(width: 58,),
  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

  SizedBox(width: 30,),

  IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

],

),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
children: [
    IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),
  SizedBox(width: 13,),

    IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),
  SizedBox(width: 13,),
    IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),
  SizedBox(width: 13,),

    IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

  SizedBox(width: 13,),

    IconButton(icon: Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 50,),onPressed: (){},),

],


),
            ),
ListTile(
  title: Row(children: [
    IconButton(onPressed: (){}, icon: Icon(Icons.add)),
    Text('2',style: TextStyle(color: Colors.black54,fontSize: 10),),
    IconButton(onPressed: (){}, icon: Icon(Icons.remove)),

  ],),
  trailing: FloatingActionButton.extended(backgroundColor: Colors.cyanAccent,
    onPressed: (){}, label:     Text('Book and Pay',style: TextStyle(color: Colors.white,fontSize: 10),),
  ),
)
           ]
          ),
        );
  }
}
