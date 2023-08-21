
const String collectionticketofUser = 'TicketsofUser';

const String ticketFieldtime = 'time';
const String ticketFieldid = 'id';
const String ticketFieldseat = 'seat';
const String ticketFieldisbook = 'booked';
const String ticketFieldfrom = 'Form';
const String ticketFieldBusName = 'BusName';
const String ticketFieldBusType = 'Bustype';
const String ticketFieldrent = 'Rent';
const String ticketFielqrto = 'to';

class TicketUserModel {
  String time;
  String id;
  int seatNumber;
  bool isBooked;
  String from;
  String BusName;
  String Bustype;
  int rent;
  String to;
  TicketUserModel({
    required this.time,
    required this.id,
    required this.from,
    required this.BusName,
    required this.Bustype,
    required this.seatNumber,
    required this.isBooked,
    required this.rent,
    required this.to
  });

  Map<String, dynamic> toMap() {
    return {
      ticketFieldtime:time,
      ticketFieldid:id,
      ticketFieldfrom: from,
      ticketFieldBusName: BusName,
      ticketFieldBusType: Bustype,
      ticketFieldseat: seatNumber,
      ticketFieldisbook: isBooked,
      ticketFieldrent: rent,
      ticketFielqrto: to,
    };
  }

  static TicketUserModel fromMap(Map<String, dynamic> map) {
    return TicketUserModel(
      time: map[ticketFieldtime],
      id: map[ticketFieldid],
      from: map[ticketFieldfrom],
      BusName: map[ticketFieldBusName],
      Bustype: map[ticketFieldBusType],
      seatNumber: map[ticketFieldseat] as int,
      isBooked: map[ticketFieldisbook],
      to: map[ticketFielqrto],
      rent: map[ticketFieldrent] as int,
    );
  }
}
