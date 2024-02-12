// import 'package:flutter/material.dart';
//
// class UpdateInfo extends StatefulWidget {
//   const UpdateInfo({super.key});
//
//   @override
//   State<UpdateInfo> createState() => _UpdateInfoState();
// }
//
// class _UpdateInfoState extends State<UpdateInfo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           TextFormField(
//
//           )
//
//         ],
//       ),
//     );
//   }
// }
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
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                obscureText: true,
              ),
              // Add more ReusableTextFormField widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}
