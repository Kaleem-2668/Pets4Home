import 'package:flutter/material.dart';
class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('User Screen'),
        centerTitle: true,
      ),

      body: const Center(child: Text('user screen',style: TextStyle(fontSize: 30),)),
    );
  }
}
