// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/data/model/response/base/api_response.dart';
import 'package:news_app/data/repository/dio/dio_client.dart';
import 'package:news_app/data/repository/exception/api_error_handler.dart';
import 'package:news_app/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  NewsRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getLatestNews() async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.GET_ALL_LATEST_NEWS}${AppConstants.API_KEY}',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCategoryNews(String selectedCategory) async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.GET_CATEGORY_LATEST_NEWS}${selectedCategory}&apiKey=${AppConstants.API_KEY}',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getAllNews(int currentPage) async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.GET_ALL_NEWS}${AppConstants.API_KEY}&page=${currentPage}',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
