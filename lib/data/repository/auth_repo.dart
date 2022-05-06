// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/data/model/response/base/api_response.dart';
import 'package:news_app/data/model/response/login_response.dart';
import 'package:news_app/data/repository/dio/dio_client.dart';
import 'package:news_app/data/repository/exception/api_error_handler.dart';
import 'package:news_app/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> login({String email, String password}) async {
    try {
      print({"email": email, "password": password});
      Response response = await dioClient.post(
        AppConstants.API_KEY,
        data: {"email": email, "password": password},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    updateToken(token);
    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
      print("object");
    } catch (e) {
      throw e;
    }
  }

  void updateToken(String token) async {
    dioClient.token = token;
    dioClient.dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.clear();
    return true;
  }

  String getUserName() {
    String fName = sharedPreferences.getString(AppConstants.FIRST_NAME) ?? "";
    String lName = sharedPreferences.getString(AppConstants.LAST_NAME) ?? "";
    return "${fName} ${lName}";
  }

  String getMobile() {
    return sharedPreferences.getString(AppConstants.MOBILE) ?? "";
  }

  String getUserImage() {
    return sharedPreferences.getString(AppConstants.USER_IMAGE) ?? "";
  }

  // for  Remember Email
  Future<void> saveUserData(Tenant tenant, String userName, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_NAME, userName);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
      await sharedPreferences.setString(AppConstants.FIRST_NAME, tenant.firstName);
      await sharedPreferences.setString(AppConstants.LAST_NAME, tenant.lastName);
      await sharedPreferences.setString(AppConstants.MOBILE, tenant.phone);
      await sharedPreferences.setString(AppConstants.USER_IMAGE, tenant.tenantImg);
    } catch (e) {
      throw e;
    }
  }
}
