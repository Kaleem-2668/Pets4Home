// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:pets_4_home/models/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserViewModel with ChangeNotifier {
//   Future<bool> saveUser(UserModel user) async {
//     try {
//       final SharedPreferences sp = await SharedPreferences.getInstance();
//       final String? authToken = user.data?.authToken;
//       if (authToken != null) {
//         sp.setString('authToken', authToken);
//         notifyListeners();
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print('Error saving user data: $e');
//       return false;
//     }
//   }
//
//   Future<UserModel?> getUser() async {
//     try {
//       final SharedPreferences sp = await SharedPreferences.getInstance();
//       final String? authToken = sp.getString('authToken');
//       if (authToken != null) {
//         return UserModel(data: Data(authToken: authToken));
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print('Error loading user data: $e');
//       return null;
//     }
//   }
//
// Future<bool>remove()async{
//     final SharedPreferences sp =await SharedPreferences.getInstance();
//     sp.remove('authToken');
//     return true;
// }
// }

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pets_4_home/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  static const String _userKey = 'user';

  Future<bool> saveUser(UserModel user) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? authToken = user.data?.authToken;
      if (authToken != null) {
        sp.setString(_userKey, jsonEncode(user.toJson()));
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error saving user data: $e');
      return false;
    }
  }

  Future<UserModel?> loadUser() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? userDataString = sp.getString(_userKey);
      print('Loaded user data: $userDataString');
      if (userDataString != null) {
        final Map<String, dynamic> userData = jsonDecode(userDataString);
        return UserModel.fromJson(userData);
      }
      return null;
    } catch (e) {
      print('Error loading user data: $e');
      return null;
    }
  }

  Future<bool> removeUser() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      return await sp.remove(_userKey);
    } catch (e) {
      print('Error deleting user data: $e');
      return false;
    }
  }
}
