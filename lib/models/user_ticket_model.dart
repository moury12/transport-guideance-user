import 'package:transport_guidance_user/models/schedule_model.dart';
import 'package:transport_guidance_user/models/ticket_model.dart';

const String collectionUserticket = 'UserTicket';

const String ticketUserFieldId = 'Id';
const String ticketUserFielduserId = 'userId';
const String ticketUserFielddate = 'date';

const String ticketUserFieldTickets = 'tickets';


class TicketUserModel {
  String id;
  TicketModel ticket;
String userId;
String date;
  TicketUserModel({
    required this.id,
    required this.ticket,
    required this.userId,
    required this.date,

  });

  Map<String, dynamic> toMap() {
    return {
      ticketUserFieldId:id,
      ticketUserFielduserId:userId,
      ticketUserFielddate:date,
      ticketUserFieldTickets: ticket.toMap(),

    };
  }

  static TicketUserModel fromMap(Map<String, dynamic> map) {
    return TicketUserModel(
      id: map[ticketUserFieldId],
      userId: map[ticketUserFielduserId],
      date: map[ticketUserFielddate],
      ticket: TicketModel.fromMap(map[ticketUserFieldTickets]),

    );
  }
}
