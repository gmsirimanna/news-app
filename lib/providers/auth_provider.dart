import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:news_app/data/model/user_model.dart';
import 'package:news_app/helper/db_helper.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/util/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  AuthProvider({this.sharedPreferences});

  User _userDetails;
  User get user => _userDetails;

  // loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> addUser(String username, String password, String email) async {
    final user = User(
      username: username,
      password: password,
      email: email,
      isLoggedIn: false,
      listOfArticles: "[]",
    );

    try {
      User userAdded = await DatabaseHelper.instance.create(user);
      if (userAdded != null) return true;
      return false;
    } catch (e) {}
    return false;
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      User user = await DatabaseHelper.instance.readUser(username, password);
      if (user != null) {
        _userDetails = user;
        addUserToken(user.id.toString());
        return true;
      }
    } catch (e) {}
    _isLoading = false;
    notifyListeners();
    return false;
  }

  saveUser(User user) {
    _userDetails = user;
    notifyListeners();
  }

  // for  user token
  Future<void> addUserToken(String token) async {
    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  Future<bool> clearSharedData() async {
    return sharedPreferences.clear();
  }

  Future<String> isUserLoggedIn() async {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }
}
