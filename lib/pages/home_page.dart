import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/pages/alternativePath_page.dart';
import 'package:transport_guidance_user/pages/feedback_page.dart';
import 'package:transport_guidance_user/pages/liveLocation_page.dart';
import 'package:transport_guidance_user/pages/notice_page.dart';
import 'package:transport_guidance_user/pages/qusen_ans_page.dart';
import 'package:transport_guidance_user/pages/request_page.dart';
import 'package:transport_guidance_user/pages/buslist_page.dart';
import 'package:transport_guidance_user/pages/tickets_page.dart';
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
  void didChangeDependencies() {
    Provider.of<UserProvider>(context, listen: false).getUserInfo();
    Provider.of<BusProvider>(context, listen: false).getAllBus();
    Provider.of<BusProvider>(context, listen: false).getAllSchedule();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(appBar:  AppBar(title:Row(
        children: [userProvider.userModel!.imageUrl!=null ?ClipOval(
          child: CachedNetworkImage(fit: BoxFit.cover,
            height: 30,
            width: 30,
            imageUrl: userProvider.userModel!.imageUrl ?? '',
            placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
            const Icon(Icons.error),
          ),
        ):Text(''),SizedBox(width: 10,),
          Text('DIU BUS',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 15),)
        ]
    ),backgroundColor: Colors.white,
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
                    SizedBox(width: 20,), InkWell(onTap: () {
                      Navigator.pushNamed(context, LiveLocationPage.routeName);
                    },
                      child: Card(
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Image.asset(
                              'assets/i3.png', height: 40, width: 40,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text('Live Location', style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 7)),
                          ),

                        ],),
                      ),
                    ),
                    SizedBox(width: 20,), InkWell(onTap: () {
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
          ), Center(
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
                      Navigator.pushNamed(context, TicketPage.routeName);
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
                      Navigator.pushNamed(context, BusListPage.routeName);
                    },
                      child: Card(
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 7, right: 7, top: 2),
                            child: Image.asset(
                              'assets/i7.png', height: 40, width: 40,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text('Bus List', style: TextStyle(
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
          ), Divider(),
          Text('--------------Bus Schedule-------------', style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 12),),Divider(),
          Expanded(
            child: ListView.builder(itemCount: provider.scheduleList.length,

              itemBuilder: (context, index) {
                final s = provider.scheduleList[index];

                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    child: Column(mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/b.jpg', height: 150, width: double.infinity,),
                        ListTile(
                          title: Text(s.busModel.busName),
                          subtitle: Text('${s.startTime}--${s.departureTime}'),
                          trailing: Column(
                            children: [
                              Text(s.busModel.passengerCategory),
                              Text('${s.busModel.facultyRent.toString()}BDT'),

                            ],
                          ),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.route, color: Colors.red,),
                            Text('${s.from}<>${s.destination}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },),
          )
        ],);

      }));
  }
}