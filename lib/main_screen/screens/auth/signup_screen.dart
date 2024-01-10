import 'package:flutter/material.dart';
import 'package:pets_4_home/main_screen/screens/auth/user_type.dart';

import '../../../widgets/constant_button.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Create account',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('And get access to additional features!'),
            ConstantButton(
                text: 'Continue With Facebook',
                color: Colors.white,
                voidCallback: () {},
                buttonColor: Colors.blue.shade700,
                icon: Icons.facebook),
            ConstantButton(
                text: 'Continue With Google',
                color: Colors.black,
                voidCallback: () {},
                buttonColor: Colors.white,
                image: 'images/google_icon.png',
                borderColor: Border.all(color: Colors.black)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.black45,
                    thickness: 1,
                    //  height: 1,
                    indent: 30,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'or use regular email address',
                  style: TextStyle(color: Colors.black45),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.black45,
                    thickness: 1,
                    //  height: 1,
                    indent: 5,
                    endIndent: 30,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                    label: const Text('E-mail address'),
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
            ),
            ConstantButton(
                text: 'Create my account',
                color: Colors.white,
                voidCallback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return const UserType();
                  }));
                },
                buttonColor: Colors.green.shade900),

            Container(
              height: MediaQuery.of(context).size.height*0.25,
                // width: double.infinity,
                margin: const EdgeInsets.only(top: 150),
                decoration: const BoxDecoration(color: Colors.black12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 18.0),
                          child: Text(
                            'Already have an account?',
                          ),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.green.shade700),
                              ),
                            )))
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
