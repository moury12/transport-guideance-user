import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/providers/busProvider.dart';

import '../constant/utils.dart';

class RoutePage extends StatefulWidget {
  static const String routeName = '/routes';
  const RoutePage({Key? key}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  String? city;
  String? city1;
  late BusProvider busProvider;
  TimeOfDay? startTime;
  @override
  void didChangeDependencies() {
    busProvider = Provider.of<BusProvider>(context, listen: false);

    Provider.of<BusProvider>(context, listen: false).getAllBus();
    Provider.of<BusProvider>(context, listen: false).getAllSchedule();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
          elevation: 0,
          title: Row(
            children: [
              Image.asset(
                'assets/logo2.png',
                height: 50,
                width: 50,
              ),
              const Text(
                'Select Route',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              )
            ],
          )),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0,top: 10),
            child: DropdownButton<String>(
                value: city1,
                hint: Row(
                  children: [Icon(Icons.location_history,color: Colors.red.shade200,),
                     Text(
                      'From',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                isExpanded: true,
                items: subDistricts
                    .map((city) => DropdownMenuItem<String>(
                    value: city, child:  Row(
                  children: [Icon(Icons.location_history,color: Colors.red.shade200,),
                    Text(
                      city,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    city1= value;
                    _findbus();
                  });
                }),
          ),
          SizedBox(
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                child: Dash(
                    direction: Axis.vertical,
                    length: 30,
                    dashLength: 4,
                    dashThickness: 2.0,
                    dashColor: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: DropdownButton<String>(
                value: city,
                hint: Row(
                  children: [Icon(Icons.location_city_sharp,color: Colors.blue.shade200,),
                    const Text('To'),
                  ],
                ),
                isExpanded: true,
                items: subDistricts
                    .map((city) => DropdownMenuItem<String>(
                    value: city, child: Row(
                  children: [Icon(Icons.location_city_sharp,color: Colors.blue.shade200,),
                    Text(
                      city,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                )))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    city = value;
                    _findbus();
                  });
                }),
          ),
          Center(
            child: TextButton.icon(
                onPressed: selectstarttime,
                icon: const Icon(Icons.departure_board,color:Colors.lightGreen,),
                label: Text(startTime == null
                    ? 'Select Time'
                    : startTime!.format(context).toString(), style: TextStyle(fontSize: 12),)),
          ),
          Center(
            child: FloatingActionButton.small(
              onPressed: _findbus,
              backgroundColor: Colors.lightGreen.shade200,
              child: const Icon(
                Icons.arrow_forward_outlined,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          buildContainer()
        ],
      ),
    );
  }

  Container buildContainer() {
    return Container(
        child: busProvider.filterScheduleList.isEmpty
            ? const Expanded(
            child: Center(
              child: Text('No bus found',style: TextStyle(fontSize: 12,color: Colors.black54),),
            ))
            : Expanded(
            child: ListView.builder(
              itemCount: busProvider.filterScheduleList.length,
              itemBuilder: (context, index) {
                final bus = busProvider.filterScheduleList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                            width: double.infinity,
                            height: 150,

                            imageUrl: bus.busModel.busImage!,
                            placeholder: (context, url) =>
                                Container(color: Colors.transparent,height: 50,
                                    width: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(color: Colors.blueAccent.withOpacity(0.5),),
                                    )),
                            errorWidget: (context, url, error) => Image.asset('assets/b.jpg')
                        ),
                      ),
                        ListTile(
                          //onTap: () => Navigator.pushNamed(
                          //   ),

                          title: Text(bus.busModel.busName,style: TextStyle(fontSize: 13)),
                          subtitle: Text("${bus.from}---${bus.startTime}---${bus.destination}",style: TextStyle(fontSize: 12)),
                          trailing:
                              Text(bus.busModel.passengerCategory,style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )));
  }

  void selectstarttime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        startTime = value!;
        _findbus();



      });
    });
  }

  void _findbus() {
    log("city $city city1 $city1 startTime $startTime");
    busProvider.getBusListbyroute(city, city1, startTime, context);
  }
}
