
const String collectionRequest = 'Request Service';
const String reqFieldstartTime = 'startTime';
const String reqFieldfrom = 'from';
const String reqFielddestination = 'destination';
const String reqFieldroutes = 'title';
const String reqFieldbusType = 'bus type';
const String reqFieldpassenger = 'passenger type';
class RequestModel{

  String startTime;
  String from;
  String destination;
  String? title;
  String bustype;
  String passengertype;


  RequestModel(
      {

        required this.startTime,

        required  this.from,
        required  this.destination,
        this.title,
        required this.bustype,
       required this.passengertype});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{

      reqFieldstartTime: startTime,

      reqFieldfrom: from,
      reqFielddestination: destination,
      reqFieldroutes: title,
      reqFieldbusType: bustype,
      reqFieldpassenger: passengertype,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) => RequestModel(
    startTime: map[reqFieldstartTime],

    from: map[reqFieldfrom],
    destination: map[reqFielddestination],
    title: map[reqFieldroutes],
    bustype: map[reqFieldbusType],
    passengertype: map[reqFieldpassenger],
  );
}