import 'package:transport_guidance_user/models/schedule_model.dart';

const String collectionticket = 'Tickets';

const String ticketFieldId = 'Id';
const String ticketFieldseat = 'seat';
const String ticketFieldisbook = 'booked';
const String ticketFieldschedule = 'Schedule';

class TicketModel {
  String id;
  final int seatNumber;
  bool isBooked;
  ScheduleModel scheduleModel;

  TicketModel({
    required this.id,
    required this.scheduleModel,
    required this.seatNumber,
    this.isBooked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      ticketFieldId:id,
      ticketFieldschedule: scheduleModel.toMap(),
      ticketFieldseat: seatNumber,
      ticketFieldisbook: isBooked,
    };
  }

  static TicketModel fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map[ticketFieldId],
      scheduleModel: ScheduleModel.fromMap(map[ticketFieldschedule]),
      seatNumber: map[ticketFieldseat] as int,
      isBooked: map[ticketFieldisbook],
    );
  }
}