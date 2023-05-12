import 'package:flutter/material.dart';
import 'package:transport_guidance_user/pages/alternativePath_page.dart';
import 'package:transport_guidance_user/pages/feedback_page.dart';
import 'package:transport_guidance_user/pages/liveLocation_page.dart';
import 'package:transport_guidance_user/pages/notice_page.dart';
import 'package:transport_guidance_user/pages/qusen_ans_page.dart';
import 'package:transport_guidance_user/pages/request_page.dart';
import 'package:transport_guidance_user/pages/settings_page.dart';
import 'package:transport_guidance_user/pages/tickets_page.dart';

import '../authservice/authentication.dart';
import 'login_pages.dart';
class HomePage extends StatelessWidget {
  static const String routeName ='/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:  AppBar(title:Row(
        children: [
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
    body: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(onTap: (){
                  Navigator.pushNamed(context, AlternativePage.routeName);
                },
                  child: Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Image.asset('assets/i1.png',height: 40,width: 40,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('Alternative Way',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),
                      ),

                    ],),
                  ),
                ),
                SizedBox(width: 20,), InkWell(onTap: (){
                  Navigator.pushNamed(context, FeedbackPage.routeName);
                },
                  child: Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5,top: 4),
                        child: Image.asset('assets/i2.png',height: 42,width: 42,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('Feedback',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),
                      ),

                    ],),
                  ),
                ),
                SizedBox(width: 20,), InkWell(onTap: (){
                  Navigator.pushNamed(context, LiveLocationPage.routeName);
                },
                  child: Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Image.asset('assets/i3.png',height: 40,width: 40,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('Live Location',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),
                      ),

                    ],),
                  ),
                ),
                SizedBox(width: 20,), InkWell(onTap: (){
                  Navigator.pushNamed(context, NoticePage.routeName);
                },
                  child: Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5),
                        child: Image.asset('assets/i4.png',height: 42,width: 42,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('Notice',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),
                      ),

                    ],),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(onTap: (){
                  Navigator.pushNamed(context, RequestPage.routeName);
                },
                  child: Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Image.asset('assets/i5.png',height: 40,width: 40,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('Request Sservice',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),
                      ),

                    ],),
                  ),
                ),
                SizedBox(width: 20,), InkWell(onTap: (){
                  Navigator.pushNamed(context, TicketPage.routeName);
                },
                  child: Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5,top: 4),
                        child: Image.asset('assets/i6.png',height: 42,width: 42,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('Ticket',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),
                      ),

                    ],),
                  ),
                ),
                SizedBox(width: 20,), InkWell(onTap: (){
                  Navigator.pushNamed(context, SettingsPage.routeName);
                },
                  child: Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 7,right: 7,top: 2),
                        child: Image.asset('assets/i7.png',height: 40,width: 40,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('Settings',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),
                      ),

                    ],),
                  ),
                ),
                SizedBox(width: 20,), InkWell(onTap: (){
                  Navigator.pushNamed(context, QusenAnsPage.routeName);
                },
                  child: Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5),
                        child: Image.asset('assets/i8.png',height: 42,width: 42,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('Ask anything',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),
                      ),

                    ],),
                  ),
                ),

              ],
            ),
          ),
        ),
      )
    ],),);
  }
}