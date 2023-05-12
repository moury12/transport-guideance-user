import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transport_guidance_user/models/userModel.dart';

import '../constant/utils.dart';
import '../providers/userProvider.dart';
class ProfilePage extends StatefulWidget {
  static const String routeName ='/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
String? thumbnailImageLocalPath;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(appBar: AppBar(backgroundColor: Colors.white,foregroundColor: Colors.black54,elevation: 0,
        title: Row(
      children: [
        Image.asset('assets/logo2.png',height: 50,width: 50,),
        Text('User Profile',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
      ],
    )),
    body: userProvider.userModel == null
        ? Center(child: Text('Failed to load user data'),):ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: _headerSection(context, userProvider),
        ),
        Card(elevation: 0,
          child: ListTile(
            leading: const Icon(
              Icons.phone,
              color: Colors.lightBlueAccent,
            ),
            subtitle: Text(
              userProvider.userModel!.phone ?? 'Not set yet',
              style: TextStyle(color:Colors.black54),
            ),  title: const Text('Phone'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(context: context, title: 'Phone', onSubmit:(value){
                  userProvider.updateUserField("$userFieldPhone", value);
                });
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.tealAccent,
              ),
            ),
          ),
        ),
        Card(elevation: 0,
          child: ListTile(
            leading: const Icon(
              Icons.fact_check_outlined,
              color: Colors.lightBlueAccent,
            ),
            subtitle: Text(
              userProvider.userModel!.versityId ?? 'Not set yet',
              style: TextStyle(color: Colors.black54),
            ),  title: const Text('University Id'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(context: context, title: 'University Id', onSubmit:(value){
                  userProvider.updateUserField("$userFieldversityId", value);
                });
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.tealAccent,
              ),
            ),
          ),
        ),
        Card(elevation: 0,
          child: ListTile(
            leading: const Icon(
              Icons.perm_identity_outlined,
              color: Colors.lightBlueAccent,
            ),
            subtitle: Text(
              userProvider.userModel!.gender ?? 'Not set yet',
              style: TextStyle(color: Colors.black54),
            ),  title: const Text('Gender'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.tealAccent,
              ),
            ),
          ),
        ),
        Card(
elevation: 0,
          child: ListTile(
            leading: const Icon(
              Icons.location_city,
              color: Colors.lightBlueAccent,
            ),  title: const Text('Current Address'),
            subtitle: Text(
              userProvider.userModel!.address ?? 'Not set yet',
              style: TextStyle(color: Colors.black54),
            ),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(context: context, title: 'Address', onSubmit:(value){
                  userProvider.updateUserField("$userFieldaddress", value);
                });
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.tealAccent,
              ),
            ),
          ),
        ),
           Card(elevation: 0,
          child: ListTile(
            leading: const Icon(
              Icons.subject_outlined,
              color: Colors.lightBlueAccent,
            ),  title: const Text('Department'),
           subtitle : Text(
              userProvider.userModel!.department ?? 'Not set yet',
              style: TextStyle(color: Colors.black54),
            ),
            trailing: IconButton(
              onPressed: () {   showSingleTextInputDialog(context: context, title: 'Department', onSubmit:(value){
                userProvider.updateUserField('$userFieldDepartment', value);
              });},
              icon: const Icon(
                Icons.edit,
                color: Colors.tealAccent,
              ),
            ),
          ),
        ), Card(
          elevation: 0,
          child: ListTile(
            leading: const Icon(
              Icons.class_outlined,
              color: Colors.lightBlueAccent,
            ),  title: const Text('Semester'),
            subtitle: Text(
              userProvider.userModel!.semester ?? 'Not set yet',
              style: TextStyle(color: Colors.black54),
            ),
            trailing: IconButton(
              onPressed: () {   showSingleTextInputDialog(context: context, title: 'Semester', onSubmit:(value){
                userProvider.updateUserField('$userFieldsemester', value);
              });},
              icon: const Icon(
                Icons.edit,
                color: Colors.tealAccent,
              ),
            ),
          ),
        ),
      ],
    ),
      );
  }

  Container _headerSection(BuildContext context, UserProvider userProvider) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white),
      child: Center(
        child: SingleChildScrollView(  scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: userProvider.userModel!.imageUrl == null
                        ? Stack(clipBehavior: Clip.none,
                          children: [
                            ClipOval(
                      child: Image.asset(
                            'assets/s.png',
                            height: 130,
                            width: 130,
                            fit: BoxFit.cover,
                      ),
                    ),
                            Positioned(right: -10,bottom: -7,
                                child: FloatingActionButton.small(onPressed: ()async{
_getImage(ImageSource.gallery);
String? downloadUrl;
downloadUrl =
    await userProvider.uploadImage(thumbnailImageLocalPath!);
userProvider.updateUserField('$userFieldimageURl', downloadUrl);
                                }, backgroundColor: Colors.cyanAccent,
                                    child: Icon(Icons.edit,size: 27,color: Colors.white,)))
                          ],
                        )
                        : ClipOval(
                      child: CachedNetworkImage(
                        filterQuality: FilterQuality.none,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        imageUrl: userProvider.userModel!
                            .imageUrl!,
                        placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    )),
              ),
              SizedBox(height: 5,),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        userProvider.userModel!.name ?? 'No Display Name',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),userProvider.userModel!.name==null ?
                      IconButton(onPressed: (){
                        showSingleTextInputDialog(context: context, title: "User Name", onSubmit: (value){
                          userProvider.updateUserField(userFieldName, value);
                        });
                      },  icon: Icon(Icons.edit,size:15,))
                          :Text('')],
                  ),

                  Text(
                    userProvider.userModel!.email ?? 'No email',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 70,
    );
    if (pickedImage != null) {
      setState(() {
        thumbnailImageLocalPath = pickedImage.path;
      });
    }
  }
}