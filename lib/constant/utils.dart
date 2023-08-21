import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

showMsg(BuildContext context, String msg) =>
    Fluttertoast.showToast(
          msg: msg,
          toastLength:
          Toast.LENGTH_SHORT, // Duration for which the toast should be visible
          gravity: ToastGravity.BOTTOM, // Toast position
          backgroundColor: Colors.black54, // Background color of the toast
          textColor: Colors.white,
          fontSize: 20, // Text color of the toast
    );
showSingleTextInputDialog({
      required BuildContext context,
      required String title,
      String positiveButtonText = 'OK',
      String negativeButtonText = 'CLOSE',
      required Function(String) onSubmit,
}) {
      final txtController = TextEditingController();
      showDialog(context: context, builder: (context) => AlertDialog(
            title: Text(title),
            content: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                        controller: txtController,
                        decoration: InputDecoration(
                              labelText: 'Enter $title',
                        ),
                  ),
            ),
            actions: [
                  TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(negativeButtonText),
                  ),
                  TextButton(
                        onPressed: () {
                              if(txtController.text.isEmpty) return;
                              onSubmit(txtController.text);
                              Navigator.pop(context);
                        },
                        child: Text(positiveButtonText),
                  )
            ],
      ));
}
const subDistricts=[
      'DSC',
      'Banani',
      'Darus-Salam',
      'Demra',
      'Dhanmondi',
      'Gulshan',
      'Jattrabari',
      'Kafrul',
      'Mirpur',
      'Mohammadpur',
      'Mugda',
      'Pallabi',
      'Paltan',
      'Shahbag',
      'Uttara',
      'Wari',
      'Narayanganj',
      'Nobinogor Savar'
];
abstract class NotificationuserType {
      static const String Notice = 'New Notice';
      static const String request = 'Accept Request';
      static const String deny = 'Deny Request';
      static const String message = 'New message';
}

abstract class NotificationType {
      static const String comment = 'New Feedback';
      static const String order = 'New Request';
      static const String ticket = 'All Tickets Booked';
      static const String message = 'New Message';
}
getFormattedDate(DateTime dt, {String pattern = 'dd/MM/yyyy'}) =>
    DateFormat(pattern).format(dt);
const serverKey ='AAAARRE404c:APA91bFM_-fURUYfiyez5r8lbjP8pfd3wVfly5jwYCBFD5HxqHZZ6Xdj2s6pnZJ1H6OnhC1oh59dQXCD5wBnstT8j-3kAWHVp8XNdjly9FViRW48ABNJXR8vhzOwypssKDPhs6xHNhbg';