import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/pages/chatScreen.dart';
import 'package:transport_guidance_user/providers/adminProvider.dart';
class QusenAnsPage extends StatelessWidget {
  static const String routeName ='/qa';
  const QusenAnsPage({Key? key}) : super(key: key);

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
              child: Text('Ask Anything',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 15))),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
      body: Consumer<AdminPtovider>(
        builder: (context, provider, child) => ListView.builder(
          itemBuilder:(context, index) {
            final user = provider.userList[index];
            return ListTile(onTap:()=> Navigator.pushNamed(context, ChatScreen.routeName, arguments: user),
              leading: ClipRRect(

                    borderRadius: BorderRadius.circular(180),


                child:Icon(Icons.account_circle, color: Colors.tealAccent,size: 50,)
              ),
              title: Text(
                  user.name??'No  Name'
              ),
              subtitle: Text(user.email),
              trailing: Text(user.phone??''),
            );
          },
          itemCount:provider.userList.length ,
        ),
      ),
    );
  }
}