import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('token', user.token.toString());
    log(pref.getString('token').toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    return UserModel(token: token);
  }

  Future<bool> removeUser() async {
    final pref = await SharedPreferences.getInstance();
    // pref.remove('token');
    return pref.clear();
  }
}
