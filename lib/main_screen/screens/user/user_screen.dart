import 'package:flutter/material.dart';
import 'package:pets_4_home/models/category_model.dart';
class UserScreen extends StatelessWidget {


   const UserScreen({Key? key,}) : super(key: key);
   // final CategoryModel? categoryData;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('User Screen'),
        centerTitle: true,
      ),

      body:  const Center(child: Text('User Screen',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
    ),);
  }
}
