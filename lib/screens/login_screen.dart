import 'package:flutter/material.dart';
import 'package:pets_4_home/screens/signup_screen.dart';


import '../widgets/constant_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child:Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      'Login',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Select an option below:'),
                    ConstantButton(
                      text: 'Continue With Facebook',
                      color: Colors.white,
                      icon: Icons.facebook,
                      voidCallback: () {},
                      buttonColor: Colors.blue.shade700,
                    ),
                    ConstantButton(
                      image: 'images/google_icon.png',
                      text: 'Continue With Google',
                      color: Colors.black,
                      voidCallback: () {},
                      borderColor: Border.all(color: Colors.black),
                      buttonColor: Colors.white,
                    ),
                    ConstantButton(
                      text: 'Continue with email',
                      color: Colors.white,
                      voidCallback: () {},
                      buttonColor: Colors.green.shade700,
                    ),
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConstantButton(
                        text: '   Sign up now',
                        color: Colors.black,
                        voidCallback: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return const SignUp();
                          }));
                        },
                        buttonColor: Colors.yellow),
                  ],
                ) ),

            Expanded(
              flex: 1,
              child: Container(
                // margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                child: Center(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'This site is protected by reCAPTCHA.Google\'s',
                              style: TextStyle(color: Colors.black),
                            ),
                            RichText(
                              text: const TextSpan(
                                text: 'Privacy policy',
                                style: TextStyle(
                                  color: Colors.green,
                                  decoration: TextDecoration.underline,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'and',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: ' Terms of Service',
                                    style: TextStyle(
                                      color: Colors.green,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' apply',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
