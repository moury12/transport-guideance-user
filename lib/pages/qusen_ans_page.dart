import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/pages/chatScreen.dart';
import 'package:transport_guidance_user/providers/adminProvider.dart';
import '../providers/userProvider.dart';

class QusenAnsPage extends StatefulWidget {
  static const String routeName = '/qa';

  @override
  State<QusenAnsPage> createState() => _QusenAnsPageState();
}

class _QusenAnsPageState extends State<QusenAnsPage> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String?;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        appBar:  AppBar(

            centerTitle: true,
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.black54,
            elevation: 0,
            title: Text(
              'Ask Anything',
              style:   GoogleFonts.bentham(),
            )),
        body: Consumer<AdminProvider>(
            builder: (context, adminProvider, child) => ListView.builder(
                  itemBuilder: (context, index) {
                    final user = adminProvider.userList[index];
                    final unreadMessagesCount = adminProvider
                        .getUnreadMessagesCountForUser(user.adminId);
                    final lastMessage = adminProvider
                        .getLastMessageForUser(userProvider.userModel!.userId);

                    return ListTile(
                      tileColor: id == null
                          ? null
                          : id == user.adminId
                              ? Colors.deepPurple.shade100
                              : null,
                      onTap: () {
                        Provider.of<AdminProvider>(context, listen: false)
                            .markMessagesAsReadForUser(user.adminId);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              admin: user,
                              user: userProvider.userModel!,
                            ),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(180),
                        child: Icon(Icons.account_circle,
                            color: Colors.red.shade200, size: 50),
                      ),trailing:  IconButton(onPressed: () {

                    }, icon: Icon(Icons.mail_rounded,color: Colors.lightBlue.shade200,)),
                      title: Text(user.name ?? 'No Name',style: GoogleFonts.bentham(fontSize: 14,fontWeight: FontWeight.w600),),
                      subtitle: Row(
                        children: [
                          Text(user.email ,style: GoogleFonts.actor(fontSize: 10),),

                        ],
                      ),
                    );
                  },
                  itemCount: adminProvider.userList.length,
                )));
  }
}
