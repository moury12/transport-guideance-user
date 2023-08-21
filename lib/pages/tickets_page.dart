import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/providers/busProvider.dart';
import 'package:qr_flutter/qr_flutter.dart';
class TicketsPage extends StatefulWidget {
  static const String routeName ='/ticket';

  const TicketsPage({Key? key}) : super(key: key);

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {@override

  @override
  Widget build(BuildContext context) {


  return Scaffold(appBar:
  AppBar(foregroundColor: Colors.black54,
      centerTitle: true,
      title: Center(
          child: Text('Tickets ',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 15))),
      backgroundColor: Colors.grey.shade200,
      elevation: 0,
    ),backgroundColor: Colors.grey.shade200,
    body: Consumer<BusProvider>(
      builder: (context, provider, child) {

        return ListView.builder(itemCount: provider.usersTicket.length,

          itemBuilder:
        (context, index) {
          final tic =provider.usersTicket[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Stack(

                children: [

                  Card(
                    clipBehavior: Clip.none,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: QrImage(
                              foregroundColor: Colors.white,
                              data: "${tic.BusName}\n${tic.from}<>${tic.to}\n"
                                  "${tic.time}", // Replace with your ticket data
                              version: QrVersions.auto,
                              size: 80.0,
                            ),
                          ),
                        ),
                        DottedDashedLine(dashColor: Colors.yellow.shade200,
                            height:75, width: 5,
                            dashHeight:6 ,
                            strokeWidth:2.5,
                            dashSpace: 4,axis: Axis.vertical),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Row(mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/logo2.png',
                                  height: 20,
                                  width: 20,
                                ),
                            Container(decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(5)
                            ),
                                child:Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(tic.BusName, style: GoogleFonts.actor(fontSize: 6,color: Colors.green),),
                                )
                            ),
                                SizedBox(width: 30,),Container(decoration: BoxDecoration(
                                color: Colors.lightBlue.shade100,
                                borderRadius: BorderRadius.circular(5)
                            ),
                                child:Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(tic.Bustype, style: GoogleFonts.actor(fontSize: 6,color: Colors.lightBlue),),
                                )
                            ) ,
                              ],
                            ),SizedBox(height: 3,width: 5,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                             SizedBox(width: 5,), Text(tic.from,style: GoogleFonts.bakbakOne(),),SizedBox(width: 5,),
                              DottedDashedLine(height: 0, width: 20,
                                  dashHeight:8 ,
                                  dashWidth:1.5,
                                  dashSpace: 3,axis: Axis.horizontal,dashColor: Colors.grey,),
                              Icon(Icons.directions_bus_sharp,size: 8,color: Colors.grey,),
                              DottedDashedLine(
                                  height: 0,
                                  width: 19,
                                  dashHeight:8 ,
                                  dashWidth:1.5,
                                  dashSpace: 3,
                                  axis: Axis.horizontal,dashColor: Colors.grey,
                              ),SizedBox(width: 5,),
                              Text(tic.to,style: GoogleFonts.bakbakOne(),),

                            ],
                            ),
                            SizedBox(width: 30,), Text(tic.time,style: GoogleFonts.cambo(color: Colors.black54,fontSize: 7),),

                            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: [

                                      Text('Seat Number',style: GoogleFonts.actor(color: Colors.black54,fontSize: 7),),
                                      Text(
                                            '${tic.seatNumber}A'.toString(),style: GoogleFonts.cambo(color: Colors.black,fontSize: 9),)
                                    ],
                                  ),
                                ) ,SizedBox(width: 5,), Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: [

                                      Text('Rent',style: GoogleFonts.actor(color: Colors.black54,fontSize: 7),),
                                      Text(
                                            '${tic.rent}৳'.toString(),style: GoogleFonts.cambo(color: Colors.black,fontSize: 9),)
                                    ],
                                  ),
                                ) ,SizedBox(width: 5,), Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: [

                                      Text('Status',style: GoogleFonts.actor(color: Colors.black54,fontSize: 7),),
                                      Text(
                                            'Booked',style: GoogleFonts.cambo(color: Colors.black,fontSize: 9),)
                                    ],
                                  ),
                                ) ,
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: -15,
                      left: 78,
                      child:Icon(Icons.circle,color: Colors.grey.shade200,size: 30,)
                  ),
                  Positioned(
                      bottom: -15,
                      left: 78,
                      child:Icon(Icons.circle,color: Colors.grey.shade200,size: 30,)
                  ),
                ],
              ),
            ),
          );

        },);
      },
    ),
  );
  }
}