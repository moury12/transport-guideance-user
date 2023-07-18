import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:transport_guidance_user/models/schedule_model.dart';
import 'package:transport_guidance_user/pages/seat_booking_page.dart';

class BusDetails extends StatefulWidget {
  static const String routeName ='/busd';
  const BusDetails({Key? key}) : super(key: key);

  @override
  State<BusDetails> createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
late ScheduleModel scheduleModel;
@override
  void didChangeDependencies() {
scheduleModel =  ModalRoute.of(context)!.settings.arguments as ScheduleModel;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:
      AppBar(
        foregroundColor: Colors.black54,
        title: Row(
          children: [
            Image.asset(
              'assets/logo2.png',
              height: 70,
              width: 70,
            ),
            Center(
                child: Text(scheduleModel.busModel.busName,
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
        child: Column(
          children: [

            Stack(clipBehavior: Clip.none,
              children: [
                scheduleModel.busModel.busImage==null?Image.asset('assets/b.jpg',height: 250,width: double.infinity,
                  fit: BoxFit.cover,):
                CachedNetworkImage(
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  imageUrl: scheduleModel.busModel.busImage!,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Positioned( left: 0,
                  right: 0,
                  bottom:-60,
                  child: Padding(
                    padding: const EdgeInsets.all(19.0),
                    child: Card(shape:RoundedRectangleBorder(side: BorderSide(width: 1,color: Colors.tealAccent),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                        child:
                        ListTile(
                          title: Column(mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  children: [Icon(Icons.location_history,color: Colors.red.shade200,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${scheduleModel.from}',style: TextStyle(color: Colors.black54,fontSize: 10),),
                                    ),
                                  ],
                                ),

                              SizedBox(
                                height: 10,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 13.0),
                                  child: Container(
                                    child: Dash(
                                        direction: Axis.vertical,
                                        length: 10,
                                        dashLength: 3,
                                        dashThickness: 1.0,
                                        dashColor: Colors.grey),
                                  ),
                                ),
                              ),
                              Row(
                                children: [Icon(Icons.location_city_sharp,color: Colors.blue.shade200,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('${scheduleModel.destination}',style: TextStyle(color: Colors.black54,fontSize: 10),),
                                  ),
                                ],
                              )
                            ],
                          ),
                          trailing:  Column(
                            children: [
                              Row(mainAxisSize: MainAxisSize.min,
                                children: [Icon(Icons.access_time_filled,color: Colors.greenAccent,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('${scheduleModel.startTime}',style: TextStyle(color: Colors.green,fontSize: 10),),
                                  ),
                                ],
                              ),
                              Text('${scheduleModel.busModel.studentRent.toString()}৳')
                            ],
                          ),
                        )
                    ),
                  ),
                )
              ],

            ),SizedBox(height: 20,),
            FloatingActionButton.extended(onPressed: ()=>
                Navigator.push(context, MaterialPageRoute(builder: (context) => SeatBookingPage(schedule:  scheduleModel),)),
            label:Text('Book a Ticket',style: TextStyle(color: Colors.white,fontSize: 10)),backgroundColor: Colors.cyanAccent,)
           , Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text('Routes',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
           ),
            Image.network(scheduleModel.routes??'',height: 200,width:double.infinity,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Assigned Driver',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
            ),
            scheduleModel.driverModel!=null?
                ListTile(
                 leading: ClipRRect(borderRadius: BorderRadius.circular(180),
                     child: Image.network(scheduleModel.driverModel!.driverLicenseImage??'',height: 50,width: 50, fit: BoxFit.cover,)),
                  title: Text(scheduleModel.driverModel!.name??'',style: TextStyle(color: Colors.lightBlue,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  trailing:

                      Text(scheduleModel.driverModel!.phone.toString()??'',style: TextStyle(color: Colors.black54,fontSize: 12),textAlign: TextAlign.left,),
                    subtitle: Text('${scheduleModel.driverModel!.email}',style: TextStyle(color: Colors.black54,fontSize: 10),),
                ):Container()
          ],
        ),
      ),
    );
  }
}
