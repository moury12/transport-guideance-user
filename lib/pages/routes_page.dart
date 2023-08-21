import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/providers/busProvider.dart';

import '../constant/utils.dart';
import 'busDetails.dart';

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
      appBar:
      AppBar(
          leading: Image.asset(
        'assets/logo2.png',
        height: 40,
        width: 40,
      ),
          centerTitle: true,
          backgroundColor: Colors.grey.shade200,
          foregroundColor: Colors.black54,
          elevation: 0,
          title: Text(
           'Select Route',
           style:   GoogleFonts.bentham(),
              )),backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
                child: Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(10) ,topRight:Radius.circular(10) )
                ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,top: 10),
                    child: DropdownButton<String>( underline: SizedBox(),

                        value: city1,
                        hint: Text(
                         'From',
                          style: GoogleFonts.bentham(),
                            ),
                        isExpanded: true,
                        items: subDistricts
                            .map((city) => DropdownMenuItem<String>(
                            value: city, child:  Text(
                              city,
                          style: GoogleFonts.bentham(),
                            ),))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            city1= value;
                            _findbus();
                          });
                        }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10) ,bottomRight:Radius.circular(10) )
                ),
                  child: DottedDashedLine(height: 0, width: double.infinity,
                    dashHeight:8 ,
                    dashWidth:5,strokeWidth: 1.5,
                    dashSpace: 5,axis: Axis.horizontal,dashColor: Colors.grey,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,top: 10),
                    child: DropdownButton<String>(
                        underline: SizedBox(),
                        value: city,
                        hint:  Text('To', style: GoogleFonts.bentham(),),
                        isExpanded: true,
                        items: subDistricts
                            .map((city) => DropdownMenuItem<String>(
                            value: city, child: Text(
                              city,
                              style: GoogleFonts.bentham(),
                            )))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            city = value;
                            _findbus();
                          });
                        }),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(onTap: ()=> selectstarttime(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:startTime == null
                          ?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.departure_board,color:Colors.white,size: 30,),
                            ):Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(startTime!.format(context).toString(), style: TextStyle(fontSize: 12),),
                            ),
                    ),
                  ),
                ),
              ),


              buildContainer()
            ],
          ),
          Positioned(top: 40
          ,right: 25,
            child: FloatingActionButton.small(
              onPressed: _findbus,
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.route,
                size: 27,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildContainer() {
    return Container(
        child: busProvider.filterScheduleList.isEmpty
            ?  Expanded(
            child: Center(
              child: Text('No bus found', style: GoogleFonts.bentham(color: Colors.black54),),
            ))
            : Expanded(
            child: ListView.builder(
              itemCount: busProvider.filterScheduleList.length,
              itemBuilder: (context, index) {
                final bus = busProvider.filterScheduleList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: ()=> Navigator.pushNamed(
                        context,
                        BusDetails.routeName,
                        arguments:bus),
                    child: Card(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(bus.busModel.busName,style:GoogleFonts.dmMono(fontSize: 8)),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                    width: 100,
                                    height: 80,
fit: BoxFit.cover,
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
                            ],
                          ),
                          Container(width: 200,height: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(children: [
                                    Text(bus.startTime,style: GoogleFonts.monda(fontSize: 12)),
                                    Text('Starting Time',style: GoogleFonts.monda(fontSize: 7,color: Colors.grey)),
                                    SizedBox(height: 60,),
                                    Text(bus.departureTime,style: GoogleFonts.monda(fontSize: 12),),
                                    Text('Departure Time',style: GoogleFonts.monda(fontSize: 7,color: Colors.grey)),
                                  ],),
                                  Column(crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.circle,size: 15,color: Colors.black,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 1.5),
                                        child: DottedDashedLine(dashColor: Colors.grey,
                                            height:37, width: 3,
                                            dashHeight:3,
                                            strokeWidth:1,
                                            dashSpace: 3,axis: Axis.vertical),
                                      ),
                                      Icon(Icons.directions_bus_sharp,size: 15,color: Colors.black,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 1.5),
                                        child: DottedDashedLine(dashColor: Colors.grey,
                                            height:38, width: 3,
                                            dashHeight:3,
                                            strokeWidth:1,
                                            dashSpace: 3,axis: Axis.vertical),
                                      ),
                                      Icon(Icons.location_on,size: 15,color: Colors.red,),
                                    ],
                                  ),
                                  Column(
                                    children: [Text("${bus.from}",style: GoogleFonts.actor(fontSize: 12)),
                                      Text('Starting point',style: GoogleFonts.monda(fontSize: 7,color: Colors.grey)),

                                      SizedBox(height: 70,),
                                      Text("${bus.destination}",style: GoogleFonts.actor(fontSize: 12),),
                                      Text('Destination',style: GoogleFonts.monda(fontSize: 7,color: Colors.grey)),





                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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
