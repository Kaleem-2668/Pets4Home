import 'package:flutter/material.dart';
import 'package:pets_4_home/main_screen/screens/appBar/setting/update_info_screen.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/auth/user_view_model.dart';
import '../../auth/login_screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
     // final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.red,
                      backgroundImage: const AssetImage('images/kaleem.jpg'),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                      )),
                  const Positioned(
                      bottom: 2,
                      right: 10,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 40,
                      ))
                ],
              ),
              const SizedBox(height: 30,),
              buildText(
                'Update',
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return const UpdateInfo();
                  }));
                },
              ),
              buildText('Terms & Condition', () {}),
              buildText('Privacy & Policy', () {}),
              buildText('Help', () {}),
              buildText('LogOut', () {
                // userPreference.removeUser().then((value) => Navigator.push(context, MaterialPageRoute(builder: (ctx){
                //   return const LoginScreen();
                // })));
              }),
            ],
          ),
        ),
      ),
    );
  }

  buildText(String text, VoidCallback? onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.080,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
