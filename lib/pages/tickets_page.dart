import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/models/schedule_model.dart';
import 'package:transport_guidance_user/models/ticket_model.dart';
import 'package:firebase_database/firebase_database.dart';

import '../providers/busProvider.dart';

class TicketPage extends StatefulWidget {
  static const String routeName = '/tick';

  final ScheduleModel schedule;

  TicketPage({required this.schedule});

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  Set<int> selectedSeats = {};
  List<int> bookedSeats = [];
  late BusProvider busProvider;

  void selectSeat(int seatIndex) {
    setState(() {
      if (selectedSeats.contains(seatIndex)) {
        selectedSeats.remove(seatIndex);
      } else {
        selectedSeats.add(seatIndex);
      }
    });
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
          ),
        );
      }
    }

    if (ticketsToBook.isNotEmpty) {
      // Perform the booking operation for the valid tickets
      for (var ticket in ticketsToBook) {
        busProvider.addTickets(ticket);
      }

      // Perform any additional actions or navigate to the next screen
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Seats Selected'),
            content: Text('Please select at least one available seat.'),
            actions: [
              ElevatedButton(
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
      appBar: AppBar(
        title: Text('Seat Selection'),
      ),
      body: FutureBuilder<List<TicketModel>>(
        future: busProvider.getallTickets(widget.schedule.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load tickets'));
          } else if (snapshot.hasData) {
            final tickets = snapshot.data!;
            bookedSeats = tickets.map((ticket) => ticket.seatNumber).toList();
            return buildSeatSelectionUI();
          } else {
            return Center(child: Text('No data available'));
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
          Text(
            'Schedule: ${widget.schedule.from}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Text(
            'Select a Seat',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
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
                    Icons.weekend,
                    color: isSeatSelected ? Colors.red : (isSeatBooked ? Colors.grey : Colors.green),
                  ),
                  onPressed: () {
                    selectSeat(index);
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            child: Text('Book Seat'),
            onPressed: () {
              bool hasSelectedSeat = selectedSeats.isNotEmpty;
              if (hasSelectedSeat) {
                bookTickets();
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('No Seats Selected'),
                      content: Text('Please select at least one seat.'),
                      actions: [
                        ElevatedButton(
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
            },
          ),
        ],
      ),
    );
  }
}
