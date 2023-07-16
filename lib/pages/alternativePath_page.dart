import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../constant/utils.dart';
class AlternativePage extends StatefulWidget {
  static const String routeName ='/altpath';
   AlternativePage({Key? key}) : super(key: key);

  @override
  State<AlternativePage> createState() => _AlternativePageState();
}

class _AlternativePageState extends State<AlternativePage> {
  String? city;

  String? city1;
List<Data> data=[
  Data(from: 'Mirpur', to: 'DSC', bus: 'Alif/KironMala > Auto / Leguna '),
  Data(from: 'Dhanmondi', to: 'DSC', bus: 'Nilachol/ Transilva/bahon > Auto > alif > leguna '),
  Data(from: 'Uttara', to: 'DSC', bus: 'Sotabdi paribohon > Auto'),
  Data(from: 'Narayanganj', to: 'DSC', bus: 'Himachol paribohon > Alif paribohon >kironmalaparibohon'),
  Data(from: 'Shahbag', to: 'DSC', bus: 'Biklpo paribohon > Alif Aribohon'),

];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      foregroundColor: Colors.black54,
      title: Row(
        children: [
          Image.asset(
            'assets/logo2.png',
            height: 70,
            width: 70,
          ),
          Center(
              child: Text('Alternative Path',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 15))),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0,top: 10),
              child: DropdownButton<String>(
                  value: city1,
                  hint: Row(
                    children: [Icon(Icons.location_history,color: Colors.red.shade200,),
                      Text(
                        'From',
                        style: TextStyle(color: Colors.black54,),
                      ),
                    ],
                  ),
                  isExpanded: true,
                  items: subDistricts
                      .map((city) => DropdownMenuItem<String>(
                    value: city, child:  Row(
                    children: [Icon(Icons.location_history,color: Colors.red.shade200,),
                      Text(
                        city,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      city1= value;
                      //_findbus();
                    });
                  }),
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: DropdownButton<String>(
                  value: city,
                  hint: Row(
                    children: [Icon(Icons.location_city_sharp,color: Colors.blue.shade200,),
                      const Text('To'),
                    ],
                  ),
                  isExpanded: true,
                  items: subDistricts
                      .map((city) => DropdownMenuItem<String>(
                      value: city, child: Row(
                    children: [Icon(Icons.location_city_sharp,color: Colors.blue.shade200,),
                      Text(
                        city,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  )))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      city = value;
                      //_findbus();
                    });
                  }),
            ),

            Center(
              child: FloatingActionButton.extended(
                onPressed: (){},
                backgroundColor: Colors.lightGreen.shade200,
                label:  Text('Search Bus')
              ),
            ),
            //buildContainer()
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 450,
                child: ListView.builder(itemCount: data.length,
                  itemBuilder: (context, index) {
                  return city1==null?Stack(clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all( 8.0),
                            child: ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    children: [ Icon(Icons.location_history,color: Colors.red.shade200,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(data[index].from,style: TextStyle(fontSize: 15,)),
                                      )
                                    ],
                                  ), SizedBox(
                                    height: 12,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(alignment: Alignment.centerLeft,
                                        child: Dash(
                                            direction: Axis.vertical,
                                            length: 12,
                                            dashLength: 2,
                                            dashThickness: 2.0,
                                            dashColor: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [ Icon(Icons.location_city_sharp,color: Colors.blue.shade200,),
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Text(data[index].to,style: TextStyle(fontSize: 15,)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
trailing: Text('30৳+'),


                              ),
                          ),

                        ),
                      ),
                      Positioned( left: 80,
                        bottom:5,

                        child: Container(width:200,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(45),color: Colors.lightGreen.shade100.withOpacity(0.6)),
                          child:  Row(
                          children: [Image.asset('assets/logo2.png',
                            height: 40,
                            width: 40,),
                            Flexible(child: Text(data[index].bus,style: TextStyle(fontSize: 10,),)),
                          ],
                        ),),
                      )
                    ],
                  ):city1==data[index].from?Stack(clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all( 8.0),
                            child: ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    children: [ Icon(Icons.location_history,color: Colors.red.shade200,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(data[index].from,style: TextStyle(fontSize: 15,)),
                                      )
                                    ],
                                  ), SizedBox(
                                    height: 12,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(alignment: Alignment.centerLeft,
                                        child: Dash(
                                            direction: Axis.vertical,
                                            length: 12,
                                            dashLength: 2,
                                            dashThickness: 2.0,
                                            dashColor: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [ Icon(Icons.location_city_sharp,color: Colors.blue.shade200,),
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Text(data[index].to,style: TextStyle(fontSize: 15,)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Text('30৳+'),


                            ),
                          ),

                        ),
                      ),
                      Positioned( left: 80,
                        bottom:5,

                        child: Container(width:200,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(45),color: Colors.lightGreen.shade100.withOpacity(0.6)),
                          child:  Row(
                            children: [Image.asset('assets/logo2.png',
                              height: 40,
                              width: 40,),
                              Flexible(child: Text(data[index].bus,style: TextStyle(fontSize: 10,),)),
                            ],
                          ),),
                      )
                    ],
                  ):SizedBox.shrink();
                },),
              ),
            )
          ],
        ),
      ),
    );

  }
}
class Data{
  final String from;
  final String to;
  final String bus;

  Data({required this.from,required this.to,required this.bus});

}