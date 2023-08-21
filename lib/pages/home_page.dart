import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/pages/alternativePath_page.dart';
import 'package:transport_guidance_user/pages/busDetails.dart';
import 'package:transport_guidance_user/pages/feedback_page.dart';
import 'package:transport_guidance_user/pages/tickets_page.dart';
import 'package:transport_guidance_user/pages/notice_page.dart';
import 'package:transport_guidance_user/pages/qusen_ans_page.dart';
import 'package:transport_guidance_user/pages/request_page.dart';
import 'package:transport_guidance_user/providers/busProvider.dart';
import 'package:transport_guidance_user/providers/userProvider.dart';
import '../authservice/authentication.dart';
import 'login_pages.dart';
class HomePage extends StatefulWidget {
  static const String routeName ='/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(backgroundColor: Colors.red.shade200,
        appBar:
    AppBar(title:Row(
        children: [userProvider.userModel?.imageUrl!=null ?ClipOval(
          child: CachedNetworkImage(fit: BoxFit.cover,
            height: 30,
            width: 30,
            imageUrl: userProvider.userModel?.imageUrl ?? '',
            placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
            const Icon(Icons.supervised_user_circle),
          ),
        ):Text(''),SizedBox(width: 10,),
          Text('DIU BUS',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 15),)
        ]
    ),backgroundColor: Colors.red.shade200,
      elevation: 0,
      foregroundColor:Colors.black54 ,
      actions: [
        IconButton(onPressed: (){
          AuthService.logout().then((value) => Navigator.pushReplacementNamed(context, LoginPage.routeName));
        }, icon: Icon(Icons.logout))
      ],
    ),
    body: Consumer<BusProvider>(
      builder: (context, provider, child) {
        return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(onTap: () {
                    Navigator.pushNamed(context, AlternativePage.routeName);
                  },
                    child: Card(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Image.asset(
                            'assets/i1.png', height: 40, width: 40,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text('Alternative Way', style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 7)),
                        ),

                      ],),
                    ),
                  ),
                  SizedBox(width: 20,), InkWell(onTap: () {
                    Navigator.pushNamed(context, FeedbackPage.routeName);
                  },
                    child: Card(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 4),
                          child: Image.asset(
                            'assets/i2.png', height: 42, width: 42,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text('Feedback', style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 7)),
                        ),

                      ],),
                    ),
                  ),
                  SizedBox(width: 20,),
                  InkWell(onTap: () {
                    Navigator.pushNamed(context, NoticePage.routeName);
                  },
                    child: Card(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Image.asset(
                            'assets/i4.png', height: 42, width: 42,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text('Notice', style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 7)),
                        ),

                      ],),
                    ),
                  ),

                ],
              ),
            ),
          ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(onTap: () {
                      Navigator.pushNamed(context, RequestPage.routeName);
                    },
                      child: Card(
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Image.asset(
                              'assets/i5.png', height: 40, width: 40,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text('Request Sservice', style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 7)),
                          ),

                        ],),
                      ),
                    ),
                    SizedBox(width: 20,), InkWell(onTap: () {
                      Navigator.pushNamed(context, TicketsPage.routeName);

                    },
                      child: Card(
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 4),
                            child: Image.asset(
                              'assets/i6.png', height: 42, width: 42,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text('Ticket', style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 7)),
                          ),

                        ],),
                      ),
                    ),

                    SizedBox(width: 20,), InkWell(onTap: () {
                      Navigator.pushNamed(context, QusenAnsPage.routeName);
                    },
                      child: Card(
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Image.asset(
                              'assets/i8.png', height: 42, width: 42,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text('Ask anything', style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 7)),
                          ),

                        ],),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),SizedBox(height: 20,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30) )),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(itemCount: provider.scheduleList.length,

                  itemBuilder: (context, index) {
                    final bus = provider.scheduleList[index];

                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: ()=> Navigator.pushNamed(
                            context,
                            BusDetails.routeName,
                            arguments:bus ),
                        child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(30)),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(bus.busModel.busName,style:GoogleFonts.dmMono(fontSize: 12,color: Colors.black)),
                                  Text('${bus.busModel.busType}|${bus.busModel.passengerCategory}',style:GoogleFonts.dmMono(fontSize: 8)),


                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                        width: 130,
                                        height: 100,
                                        fit: BoxFit.contain,
                                        imageUrl: bus.busModel.busImage!,
                                        placeholder: (context, url) =>
                                            Container(color: Colors.transparent,height: 50,
                                                width: 50,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CircularProgressIndicator(color: Colors.blueAccent.withOpacity(0.5),),
                                                )),
                                        errorWidget: (context, url, error) => Image.asset('assets/b.jpg')
                                    ),
                                  ),
                                ],
                              ),
                              Container(width: 200,height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child:  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(children: [
                                        Text(bus.startTime,style: GoogleFonts.monda(fontSize: 12)),
                                        Text('Starting Time',style: GoogleFonts.monda(fontSize: 7,color: Colors.grey)),
                                        SizedBox(height: 60,),
                                        Text(bus.departureTime,style: GoogleFonts.monda(fontSize: 12),),
                                        Text('Departure Time',style: GoogleFonts.monda(fontSize: 7,color: Colors.grey)),
                                      ],),
                                      Column(crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.circle,size: 15,color: Colors.black,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 1.5),
                                            child: DottedDashedLine(dashColor: Colors.grey,
                                                height:37, width: 3,
                                                dashHeight:3,
                                                strokeWidth:1,
                                                dashSpace: 3,axis: Axis.vertical),
                                          ),
                                          Icon(Icons.directions_bus_sharp,size: 15,color: Colors.black,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 1.5),
                                            child: DottedDashedLine(dashColor: Colors.grey,
                                                height:38, width: 3,
                                                dashHeight:3,
                                                strokeWidth:1,
                                                dashSpace: 3,axis: Axis.vertical),
                                          ),
                                          Icon(Icons.location_on,size: 15,color: Colors.red,),
                                        ],
                                      ),
                                      Column(
                                        children: [Text("${bus.from}",style: GoogleFonts.actor(fontSize: 12)),
                                          Text('Starting point',style: GoogleFonts.monda(fontSize: 7,color: Colors.grey)),

                                          SizedBox(height: 70,),
                                          Text("${bus.destination}",style: GoogleFonts.actor(fontSize: 12),),
                                          Text('Destination',style: GoogleFonts.monda(fontSize: 7,color: Colors.grey)),





                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },),
              ),
            ),
          )
        ],);

      }));
  }
}