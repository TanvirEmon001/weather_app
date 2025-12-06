import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/models/user_model.dart';

class AuthController {
  static const String _accessTokenKey = 'token';
  static const String _userModelKey = 'user-model';

  static String? accessKey;
  static UserModel? userModel;

  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    await prefs.setString(_accessTokenKey, token);
    await prefs.setString(_userModelKey, jsonEncode(model.toJson()));
    accessKey = token;
    userModel = model;
  }

  static Future<void> updateUserData(UserModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userModelKey, jsonEncode(model.toJson()));
  }

  static Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_accessTokenKey);

    if (token != null){
      String? userData = prefs.getString(_userModelKey);
      userModel = UserModel.fromJson(jsonDecode(userData!));
      accessKey = token;
    }

  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getToken = prefs.getString(_accessTokenKey);

    return getToken != null;
  }

  static Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }


}