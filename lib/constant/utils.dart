import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(margin: EdgeInsets.all(5),
      content: Text(msg),backgroundColor: Colors.blue.shade200.withOpacity(0.5),
      behavior: SnackBarBehavior.floating,));
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
}
abstract class NotificationType {
      static const String comment = 'New Feedback';
      static const String order = 'New Request';
      static const String user = 'New ticket';
}
getFormattedDate(DateTime dt, {String pattern = 'dd/MM/yyyy'}) =>
    DateFormat(pattern).format(dt);
const serverKey ='AAAARRE404c:APA91bFM_-fURUYfiyez5r8lbjP8pfd3wVfly5jwYCBFD5HxqHZZ6Xdj2s6pnZJ1H6OnhC1oh59dQXCD5wBnstT8j-3kAWHVp8XNdjly9FViRW48ABNJXR8vhzOwypssKDPhs6xHNhbg';