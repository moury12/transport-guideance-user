import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/providers/busProvider.dart';
class BusListPage extends StatelessWidget {
  static const String routeName ='/stg';
  const BusListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final busprovider = Provider.of<BusProvider>(context);
    return Scaffold(appBar: AppBar(title: Row(
      children: [Image.asset('assets/i7.png',height: 30,width: 30,),
        Text('Bus List',style: TextStyle(fontSize: 18),),
      ],
    ),toolbarHeight: 40, elevation:0,backgroundColor: Colors.transparent,foregroundColor: Colors.black54,centerTitle: true,),
    body:
        Consumer<BusProvider>(
          builder: (context, provider, child) {
            return
            ListView.builder(itemCount: provider.busList.length,

              itemBuilder: (context, index) {
                final s = provider.busList[index];

                return Padding(
                  padding: const EdgeInsets.all(2.0),

                    child: Card(
                      child: Column(mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network( s.busImage??'', height: 150, width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                             return Image.asset('assets/b.jpg') ;
                            },
                            ),
                          ListTile(
                            title: Text(s.busName),
                            subtitle: Text('${s.passengerCategory} Bus'),
                            trailing:
                                Text('${s.studentRent.toString()}BDT'),



                          ),

                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.bus_alert, color: Colors.red,),
                              Text('${s.busType}<>${s.destination}'),
                            ],
                          ),
                        ],
                      ),
                    ),

                );
              },);
          },
        )

    );
  }
}