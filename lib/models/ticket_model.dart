import 'package:transport_guidance_user/models/schedule_model.dart';
import 'package:transport_guidance_user/models/user_ticket_model.dart';

const String collectionticket = 'Tickets';

const String ticketFieldId = 'Id';
const String ticketFieldseat = 'seat';
const String ticketFieldisbook = 'booked';
const String ticketFieldschedule = 'Schedule';
const String ticketFieldrent = 'Rent';
const String ticketFielqrCode = 'qrCode';

class TicketModel {
  String id;
  final int seatNumber;
  bool isBooked;
  ScheduleModel scheduleModel;
  int? rent;
  String? qrCode;
  TicketModel({
    required this.id,
    required this.scheduleModel,
    required this.seatNumber,
    this.isBooked = false,
    this.rent,
    this.qrCode
  });

  Map<String, dynamic> toMap() {
    return {
      ticketFieldId:id,
      ticketFieldschedule: scheduleModel.toMap(),
      ticketFieldseat: seatNumber,
      ticketFieldisbook: isBooked,
      ticketFieldrent: rent,
      ticketFielqrCode: qrCode,
    };
  }

  static TicketModel fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map[ticketFieldId],
      scheduleModel: ScheduleModel.fromMap(map[ticketFieldschedule]),
      seatNumber: map[ticketFieldseat] as int,
      isBooked: map[ticketFieldisbook],
      qrCode: map[ticketFielqrCode],
      rent: map[ticketFieldrent] as int,
    );
  }
}
class TicketItem{
  TicketUserModel ticketUserModel;
  bool isExpanded;

  TicketItem({required this.ticketUserModel, this.isExpanded=false});
}