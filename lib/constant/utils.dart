import 'package:flutter/material.dart';

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