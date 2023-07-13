import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/models/reqModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constant/utils.dart';
import '../models/notification_model.dart';
import '../providers/busProvider.dart';
import 'dashboard_page.dart';

class RequestPage extends StatefulWidget {
  static const String routeName = '/req';
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  String? city1;
  String? city;

  TextEditingController _textController = TextEditingController();
  String busTypeGroupValue = 'Regular Transport';
  String passengerTypeGroupValue = 'Student';
  TimeOfDay startTime = TimeOfDay(hour: 00, minute: 00);
  late BusProvider busprovider;
  @override
  void didChangeDependencies() {
    busprovider = Provider.of<BusProvider>(context, listen: false);
    //requestModel = ModalRoute.of(context)!.settings.arguments as RequestModel;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 2,
            ),
            Text(
              'Service Request',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        toolbarHeight: 40,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Container(
                  child: DropdownButton<String>(
                      value: city1,
                      hint: Row(
                        children: [
                          Icon(
                            Icons.location_history,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Pick-up Location',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      isExpanded: true,
                      items: subDistricts
                          .map((city) => DropdownMenuItem<String>(
                                value: city,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_history,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      city,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          city1 = value;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  child: Dash(
                      direction: Axis.vertical,
                      length: 30,
                      dashLength: 4,
                      dashThickness: 2.0,
                      dashColor: Colors.grey),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  child: DropdownButton<String>(
                      value: city,
                      hint: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.cyanAccent,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Drop-off Location',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      isExpanded: true,
                      items: subDistricts
                          .map((city) => DropdownMenuItem<String>(
                                value: city,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.cyanAccent,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      city,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          city = value;
                        });
                      }),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextButton.icon(
                    onPressed: selectstarttime,
                    icon: Icon(
                      Icons.more_time_outlined,
                      color: Colors.greenAccent,
                    ),
                    label: Text(
                      startTime.hour == 0
                          ? 'Pick-up time'
                          : startTime.format(context).toString(),
                      style: TextStyle(fontSize: 12),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select Bus type',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Row(
              children: [
                Radio<String>(
                    activeColor: Colors.red,
                    hoverColor: Colors.red,
                    focusColor: Colors.red,
                    fillColor:
                        MaterialStateColor.resolveWith((states) => Colors.red),
                    value: 'Regular Transport',
                    groupValue: busTypeGroupValue,
                    onChanged: (value) {
                      setState(() {
                        busTypeGroupValue = value!;
                      });
                    }),
                Text('Regular Transport'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                    activeColor: Colors.red,
                    hoverColor: Colors.red,
                    focusColor: Colors.red,
                    fillColor:
                        MaterialStateColor.resolveWith((states) => Colors.red),
                    value: 'Shuttle service',
                    groupValue: busTypeGroupValue,
                    onChanged: (value) {
                      setState(() {
                        busTypeGroupValue = value!;
                      });
                    }),
                Text('Shuttle service'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                    activeColor: Colors.red,
                    hoverColor: Colors.red,
                    focusColor: Colors.red,
                    fillColor:
                        MaterialStateColor.resolveWith((states) => Colors.red),
                    value: 'Female Bus',
                    groupValue: busTypeGroupValue,
                    onChanged: (value) {
                      setState(() {
                        busTypeGroupValue = value!;
                      });
                    }),
                Text('Female Bus'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select Passenger Category ',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Row(
              children: [
                Radio<String>(
                    activeColor: Colors.cyanAccent,
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.cyanAccent),
                    value: 'Faculty',
                    groupValue: passengerTypeGroupValue,
                    onChanged: (value) {
                      setState(() {
                        passengerTypeGroupValue = value!;
                      });
                    }),
                Text('Faculty'),
                Radio<String>(
                    activeColor: Colors.cyanAccent,
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.cyanAccent),
                    value: 'Student',
                    groupValue: passengerTypeGroupValue,
                    onChanged: (value) {
                      setState(() {
                        passengerTypeGroupValue = value!;
                      });
                    }),
                Text('Student'),
                Radio<String>(
                    activeColor: Colors.cyanAccent,
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.cyanAccent),
                    value: 'Stuff',
                    groupValue: passengerTypeGroupValue,
                    onChanged: (value) {
                      setState(() {
                        passengerTypeGroupValue = value!;
                      });
                    }),
                Text('Stuff'),
              ],
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(maxLines: 3,controller:_textController ,
                decoration: InputDecoration(
                  border: OutlineInputBorder(

                  ),
                 hintText:'Reason of request(Optional)',hintStyle: TextStyle(fontSize: 13,color: Colors.black54)
              ),),
            ),
            SizedBox(height: 5,),
            Center(
              child: FloatingActionButton.extended(
                onPressed: _sendReq,
                elevation: 1,
                label: Text(
                  'Send Request',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.tealAccent,
              ),
            ),

          ],
        ),
      ),
    );
  }

  void selectstarttime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        startTime = value!;
      });
    });
  }

  void _sendReq() async{
    if (city == null) {
      showMsg(context, 'Field required');
      return;
    }
    if (city1 == null) {
      showMsg(context, 'Field required');
      return;
    }
    if(startTime==null){
      showMsg(context, 'Field required');
      return;
    }
    EasyLoading.show(status: 'Please wait');
    final requestBus = RequestModel(

        startTime: startTime.format(context).toString(),
        bustype:busTypeGroupValue,
        passengertype: passengerTypeGroupValue,
        title: _textController.text,
        from: city!,
        destination: city1!);
    try {
      await busprovider.addRequestBus(requestBus);
      _notifyUser(requestBus);
      EasyLoading.dismiss();
      if (mounted) {
        showMsg(context, "Sent Request to the Admin");

       // showMsg(context, 'Thanks for your feedback, your feedback is waiting for admin read');
        final notificationModel =NotificationModel(id: DateTime.now().microsecondsSinceEpoch.toString(),
            type: NotificationType.order,
            message: 'User  request for a bus which is waiting for admin approval',orderModel:requestBus );
        await Provider.of<BusProvider>(context,listen: false).addNotification(notificationModel);

        Navigator.pushReplacementNamed(context, DashboardPage.routeName);
      }
    } catch (error) {
      EasyLoading.dismiss();
      rethrow;
    }
  }
  void _notifyUser(RequestModel requestBus) async {
    final url = 'https://fcm.googleapis.com/fcm/send';
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };
    final body = {
      "to": "/topics/feedback",
      "notification": {
        "title": "A New Schedule request for ${requestBus.startTime} ",
        "body": "Please provide a bus on this ${requestBus.from}<>${requestBus.destination} route as soon as possible "
      },
      "data": {"key": "request", "value": requestBus.startTime}
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: json.encode(body),
      );

    } catch (error) {
      print(error.toString());
    }
  }
}
