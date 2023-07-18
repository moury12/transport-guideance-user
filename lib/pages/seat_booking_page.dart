import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_dash/flutter_dash.dart';
import 'package:qr/qr.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:transport_guidance_user/authservice/authentication.dart';
import 'package:transport_guidance_user/constant/utils.dart';
import 'package:transport_guidance_user/models/schedule_model.dart';
import 'package:transport_guidance_user/models/ticket_model.dart';
import 'package:transport_guidance_user/models/user_ticket_model.dart';

import '../providers/busProvider.dart';
import '../providers/userProvider.dart';

class SeatBookingPage extends StatefulWidget {
  static const String routeName = '/seat';

  final ScheduleModel schedule;

  SeatBookingPage({required this.schedule});

  @override
  _SeatBookingPageState createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends State<SeatBookingPage> {
  Set<int> selectedSeats = {};
  List<int> bookedSeats = [];
  late BusProvider busProvider;
  String img='';
  GlobalKey qrImageKey = GlobalKey();

  void selectSeat(int seatIndex) {
    setState(() {
      if (selectedSeats.contains(seatIndex)) {
        selectedSeats.remove(seatIndex);
      } else {
        selectedSeats.add(seatIndex);
      }
    });
  }
  int calculateTotalPrice() {
    final seatPrice = widget.schedule.busModel.studentRent.toInt(); // Change this to the desired seat price
    return selectedSeats.length * seatPrice;
  }
  void didChangeDependencies() {
    busProvider = Provider.of<BusProvider>(context, listen: false);
    super.didChangeDependencies();
  }
  void bookTickets() {
    List<TicketModel> ticketsToBook = [];

    for (int seatIndex in selectedSeats) {
      int seatNumber = seatIndex + 1;

      // Check if the seat is already booked
      bool isSeatAlreadyBooked = bookedSeats.contains(seatNumber);

      if (!isSeatAlreadyBooked) {

          ticketsToBook.add(
            TicketModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                scheduleModel: widget.schedule,
                seatNumber: seatNumber,
                isBooked: true,
                rent: calculateTotalPrice(),
                ),
          );

      }
    }

    if (ticketsToBook.isNotEmpty) {
      // Perform the booking operation for the valid tickets
      for (var ticket in ticketsToBook) {
        busProvider.addTickets(ticket);

        final userTicket= TicketUserModel(id: '${DateTime.now().millisecondsSinceEpoch.toString()}', ticket: ticket, userId: AuthService.currentUser!.uid, date:getFormattedDate(DateTime.now(), pattern: 'dd/MM/yyyy') );
        busProvider.addUserTicket(userTicket);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Booking Successful!',style: TextStyle(color: Colors.lightBlue,fontSize: 12,fontWeight: FontWeight.bold)),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Your tickets have been booked',style: TextStyle(color: Colors.black45,fontSize: 10,)),
                  SizedBox(height: 5),

                  QrImage(
                    data: ticket.id, // Replace with your ticket data
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ],
              ),
              actions: [
                Text("Take a Screenshot of your Qr Code",style: TextStyle(color: Colors.red,fontSize: 10,fontWeight: FontWeight.bold)),
                FloatingActionButton.small(backgroundColor: Colors.pinkAccent,
                  child: Icon(Icons.close,),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },




          // Perform any additional actions or navigate to the next screen
        );
      } } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('''Don't Select booked seat''',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold)),
            content: Text('Please select at least one available seat.',style: TextStyle(color: Colors.black54,fontSize: 10)),
            actions: [
              FloatingActionButton(backgroundColor: Colors.pinkAccent,
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );

        },
      );
    }
  }








  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.black54,
        title: Row(
          children: [
            Image.asset(
              'assets/logo2.png',
              height: 70,
              width: 70,
            ),
            Center(
                child: Text('Ticket Booking ',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<TicketModel>>(
        future: busProvider.getallTickets(widget.schedule.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Failed to load tickets',style: TextStyle(color: Colors.black54,fontSize: 10)));
          } else if (snapshot.hasData) {
            final tickets = snapshot.data!;
            bookedSeats = tickets.map((ticket) => ticket.seatNumber).toList();
            return buildSeatSelectionUI();
          } else {
            return Center(child: Text('No data available',style: TextStyle(color: Colors.black54,fontSize: 10),));
          }
        },
      ),
    );
  }

  Widget buildSeatSelectionUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 19.0,right: 19),
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
                            child: Text('${widget.schedule.from}',style: TextStyle(color: Colors.black54,fontSize: 10),),
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
                            child: Text('${widget.schedule.destination}',style: TextStyle(color: Colors.black54,fontSize: 10),),
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
                            child: Text('${widget.schedule.startTime}',style: TextStyle(color: Colors.green,fontSize: 10),),
                          ),
                        ],
                      ),
                      Text('${widget.schedule.busModel.studentRent.toString()}৳')
                    ],
                  ),
                )
            ),
          ),
          SizedBox(height: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(onPressed: (){}, icon:
                Icon(Icons.square_rounded,color: Colors.pinkAccent,size: 22,),

             label: Text('Selected',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),),),TextButton.icon(onPressed: (){}, icon:
                Icon(Icons.square_rounded,color: Colors.lightBlueAccent,size: 22,),

             label: Text('Booked',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),),),
            TextButton.icon(onPressed: (){}, icon:
                Icon(Icons.square_rounded,color: Colors.greenAccent,size: 22,),

             label: Text('Available',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),),),
          ],
        ),
          //SizedBox(height: 0),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                bool isSeatSelected = selectedSeats.contains(index);
                bool isSeatBooked = bookedSeats.contains(index + 1);
                return IconButton(
                  icon: Icon(
                    Icons.square_rounded,size: 45,
                    color: isSeatSelected ? Colors.pinkAccent : (isSeatBooked ? Colors.lightBlueAccent : Colors.greenAccent),
                  ),
                  onPressed: () {
                    selectSeat(index);
                  },
                );
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [TextButton.icon(icon:Icon(Icons.event_seat,color: Colors.pink) ,
            label:Text ( ' ${selectedSeats.length}',
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.pink),),onPressed: () {
                
              },
            ),TextButton.icon(icon:Icon(Icons.car_rental,color: Colors.greenAccent) ,
              label:Text ( '${calculateTotalPrice()}৳',
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),onPressed: () {

              },
            ),

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: FloatingActionButton.extended(backgroundColor: Colors.lightBlueAccent,
                  label: Text('Book now'),
                  onPressed: () {
                    bool hasSelectedSeat = selectedSeats.isNotEmpty;
                    if (hasSelectedSeat) {
                      bookTickets();
                    } else {showDialog(
    context: context,
    builder: (BuildContext context) {
                    return  AlertDialog(
                        title: Text('No Seats Selected',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold)),
                        content: Text('Please select at least one available seat.',style: TextStyle(color: Colors.black54,fontSize: 10)),
                        actions: [
                          FloatingActionButton(backgroundColor: Colors.pinkAccent,
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );    });                }
                  },
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
