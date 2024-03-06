import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';


class UserViewModel with ChangeNotifier {
  static const String _userKey = 'user';

  Future<bool> saveUser(UserModel user) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? authToken = user.data?.authToken;
      if (authToken != null) {
        sp.setString(_userKey, jsonEncode(user.toJson()));
        print('Saved user data. AuthToken: $authToken');
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
        print('Decoded user data: $userData');
        final UserModel userModel = UserModel.fromJson(userData);
        final String? authToken = userModel.data?.authToken;
        if (authToken != null) {
          print('User AuthToken: $authToken');
        }
        return userModel;
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
