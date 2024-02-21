import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pets_4_home/main_screen/screens/home/home_screen.dart';

import 'package:pets_4_home/repository/auth_repository.dart';

import '../../models/article_model.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  Future<void> registerApi(dynamic data, BuildContext context) async {
    _myRepo.registerApi(data).then((value) {
      if (kDebugMode) {
        print('////////////////////////////registerApi//////////////////////////////////');
      }

      Fluttertoast.showToast(msg: 'User registered successfully');
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Fluttertoast.showToast(msg: error.toString());
        print(error.toString());
      }
    });
  }
  Future<void> loginApi(dynamic data, BuildContext context) async {

    _myRepo.loginApi(data).then((value) {
      print('////////////////////////LoginApi//////////////////////////////////////');

      Fluttertoast.showToast(msg: 'User LogIn successfully');
      Navigator.push(context, MaterialPageRoute(builder: (ctx){
        return  HomeScreen();
      }));
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {

      if (kDebugMode) {
        Fluttertoast.showToast(msg: error.toString());
        print(error.toString());
      }
    });
  }

  }

