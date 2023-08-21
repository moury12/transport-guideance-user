import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class NoticePage extends StatelessWidget {
  static const String routeName ='/notice';
  const NoticePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:
    AppBar(

        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
        foregroundColor: Colors.black54,
        elevation: 0,
        title: Text(
          'Notice',
          style:   GoogleFonts.bentham(),
        )),);
  }
}