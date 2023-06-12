import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/providers/busProvider.dart';
class BusListPage extends StatelessWidget {
  static const String routeName ='/stg';
  const BusListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Row(
      children: [Image.asset('assets/i7.png',height: 30,width: 30,),
        Text('Bus List',style: TextStyle(fontSize: 18),),
      ],
    ),toolbarHeight: 40, elevation:0,backgroundColor: Colors.transparent,foregroundColor: Colors.black54,centerTitle: true,),
    body: Consumer<BusProvider>(
      builder: (context, provider, child) {
        return Expanded(child: Column());
      },
    ),
    );
  }
}