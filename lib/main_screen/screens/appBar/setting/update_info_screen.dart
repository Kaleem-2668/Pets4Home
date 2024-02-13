import 'package:flutter/material.dart';

class ReusableTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;

  const ReusableTextFormField({super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          labelText: labelText,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }
}

class UpdateInfo extends StatefulWidget {
  const UpdateInfo({Key? key}) : super(key: key);

  @override
  State<UpdateInfo> createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
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
                  ]),
              const Positioned(
                  bottom: 2,
                  right: 10,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 40,
                  )),
              const SizedBox(height: 30,),
              ReusableTextFormField(
                controller: _usernameController,
                labelText: 'Username',
              ),
              ReusableTextFormField(
                controller: _emailController,
                labelText: 'Email',
              ),
              ReusableTextFormField(
                controller: _addressController,
                labelText: 'Address',

              ),
              ReusableTextFormField(
                controller: _cityController,
                labelText: 'City',
              ),

            ],


          ),
        ),
      ),
    );
  }
}
