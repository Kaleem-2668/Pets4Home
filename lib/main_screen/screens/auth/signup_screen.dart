import 'package:flutter/material.dart';
import 'package:pets_4_home/main_screen/screens/auth/user_type.dart';
import '../../../widgets/constant_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPassVisible = false;

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

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

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Create account',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
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
                      indent: 5,
                      endIndent: 30,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: TextFormField(
                  controller: emailController,
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
                      _emailError = _validateEmail(value);
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextFormField(
                  controller: passwordController,
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
                      _passwordError = _validatePassword(value);
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: TextFormField(
                  controller: confirmController,
                  obscureText: _isConfirmPassVisible,
                  decoration: InputDecoration(
                    label: const Text('Confirm password'),
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: _confirmPasswordError,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPassVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPassVisible = !_isConfirmPassVisible;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _confirmPasswordError =
                          _validateConfirmPassword(value);
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              ConstantButton(
                text: 'Create my account',
                color: Colors.white,
                voidCallback: () {
                  setState(() {
                    _emailError = _validateEmail(emailController.text);
                    _passwordError =
                        _validatePassword(passwordController.text);
                    _confirmPasswordError =
                        _validateConfirmPassword(confirmController.text);
                  });

                  if (_emailError == null &&
                      _passwordError == null &&
                      _confirmPasswordError == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => UserType(
                          userEmail: emailController.text,
                          userPassword: passwordController.text,
                          confirmPass: confirmController.text,
                        ),
                      ),
                    );
                  }
                },
                buttonColor: Colors.green.shade900,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
