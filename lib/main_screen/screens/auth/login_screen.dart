import 'package:flutter/material.dart';

import 'package:pets_4_home/main_screen/screens/auth/signup_screen.dart';
import 'package:pets_4_home/view_model/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../../widgets/constant_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;
  String? _emailError;
  String? _passwordError;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }

    // Use a regular expression to validate the email format
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (value.length < 4) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: const Text('E-mail address'),
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: _emailError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _emailError = _validateEmail(value.trim());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _isPasswordVisible,
                  decoration: InputDecoration(
                    label: const Text('Enter password'),
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: _passwordError,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _passwordError = _validatePassword(value.trim());
                    });
                  },
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return SignUp();
                  }));
                },
                child: const Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ConstantButton(

                  text: 'SigIn',
                  color: Colors.black,

                  voidCallback: () {
                    Map data ={
                      'email':_emailController.text.toString(),
                      'password':_passwordController.text.toString()
                    };
                    authViewModel.loginApi(data, context);
                  },
                  buttonColor: Colors.green),
              const SizedBox(height: 20,),


              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     // margin: const EdgeInsets.only(top: 15),
              //     alignment: Alignment.bottomCenter,
              //     decoration: const BoxDecoration(
              //       color: Colors.black12,
              //     ),
              //     child: Center(
              //       child: Align(
              //         alignment: Alignment.topCenter,
              //         child: Padding(
              //             padding: const EdgeInsets.symmetric(
              //                 horizontal: 5, vertical: 20),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 const Text(
              //                   'This site is protected by reCAPTCHA.Google\'s',
              //                   style: TextStyle(color: Colors.black),
              //                 ),
              //                 RichText(
              //                   text: const TextSpan(
              //                     text: 'Privacy policy',
              //                     style: TextStyle(
              //                       color: Colors.green,
              //                       decoration: TextDecoration.underline,
              //                     ),
              //                     children: [
              //                       TextSpan(
              //                         text: 'and',
              //                         style: TextStyle(color: Colors.black),
              //                       ),
              //                       TextSpan(
              //                         text: ' Terms of Service',
              //                         style: TextStyle(
              //                           color: Colors.green,
              //                           decoration: TextDecoration.underline,
              //                         ),
              //                       ),
              //                       TextSpan(
              //                         text: ' apply',
              //                         style: TextStyle(color: Colors.black),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             )
              //             ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
