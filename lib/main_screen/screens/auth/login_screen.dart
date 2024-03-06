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
                    value = value.trim(); // Trim the input value
                    setState(() {
                      _emailController.text = value; // Update the controller's text
                      _emailError = _validateEmail(value);
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
                        _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
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
                    value = value.trim(); // Trim the input value
                    setState(() {
                      _passwordController.text = value; // Update the controller's text
                      _passwordError = _validatePassword(value);
                    });
                  },
                ),

              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return const SignUp();
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
                  color: Colors.white,
                  voidCallback: () {
                    Map data ={
                      'email':_emailController.text.toString(),
                      'password':_passwordController.text.toString()
                    };
                    authViewModel.loginApi(data, context);
                  },
                  buttonColor: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
