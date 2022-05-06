import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/data/model/artical_model.dart';
import 'package:news_app/data/model/response/base/api_response.dart';
import 'package:news_app/data/model/response/news_response.dart';
import 'package:news_app/data/model/user_model.dart';
import 'package:news_app/data/repository/news_repo.dart';
import 'package:news_app/helper/db_helper.dart';

class NewsProvider with ChangeNotifier {
  final NewsRepo newsRepo;

  NewsProvider({@required this.newsRepo});

  int _currentLatestNewsIndex = 0;
  int _currentPage = 0;
  String _selectedCategory = "Business";

  int get currentLatestNewsIndex => _currentLatestNewsIndex;
  int get currentPage => _currentPage;
  String get selectedCategory => _selectedCategory;

  //Article lists
  List<Article> _latestNewsList = [];
  List<Article> get latestNewsList => _latestNewsList;
  List<Article> _categoryNewsList = [];
  List<Article> get categoryNewsList => _categoryNewsList;
  List<Article> _allNewsList = [];
  List<Article> get allNewsList => _allNewsList;
  List<Article> _favouriteArtilse = [];
  List<Article> get favouriteArtilse => _favouriteArtilse;

  // loading
  bool _isLoadingLatestNews = true;
  bool _isLoadingCategoryNews = true;
  bool _isLoadingAllNews = true;

  bool get isLoadingLatestNews => _isLoadingLatestNews;
  bool get isLoadingCategoryNews => _isLoadingCategoryNews;
  bool get isLoadingAllNews => _isLoadingAllNews;

  //Error message section
  String _latestNewsErrorMessage = '';
  String _categoryNewsErrorMessage = '';
  String _allNewsErrorMessage = '';
  String get latestNewsErrorMessage => _latestNewsErrorMessage;
  String get categoryNewsErrorMessage => _categoryNewsErrorMessage;
  String get allNewsErrorMessage => _allNewsErrorMessage;

  //get all articles
  Future<void> getLatestNewsList() async {
    _isLoadingLatestNews = true;
    _latestNewsErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await newsRepo.getLatestNews();
    NewsResponse latestNewsResponse;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      latestNewsResponse = NewsResponse.fromJson(map);
      _latestNewsList = latestNewsResponse.articles;
    } else {
      _latestNewsList = [];
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      _latestNewsErrorMessage = errorMessage;
    }
    _isLoadingLatestNews = false;
    notifyListeners();
  }

  //get category articles
  Future<void> getCategoryArticles() async {
    _isLoadingCategoryNews = true;
    _allNewsErrorMessage = '';
    _categoryNewsList = [];
    notifyListeners();
    ApiResponse apiResponse = await newsRepo.getCategoryNews(_selectedCategory.toLowerCase());
    NewsResponse latesCategorytNewsResponse;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      latesCategorytNewsResponse = NewsResponse.fromJson(map);
      _categoryNewsList = latesCategorytNewsResponse.articles;
    } else {
      _categoryNewsList = [];
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      _categoryNewsErrorMessage = errorMessage;
    }
    _isLoadingCategoryNews = false;
    notifyListeners();
  }

  //get all articles by paginate
  Future<void> getAllNews() async {
    _isLoadingAllNews = true;
    _categoryNewsErrorMessage = '';
    _allNewsList = [];
    notifyListeners();
    ApiResponse apiResponse = await newsRepo.getAllNews(_currentPage);
    NewsResponse allNewsResponse;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      allNewsResponse = NewsResponse.fromJson(map);
      _allNewsList = (allNewsResponse.articles);
    } else {
      _allNewsList = [];
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      _allNewsErrorMessage = errorMessage;
    }
    _isLoadingAllNews = false;
    notifyListeners();
  }

  void setCurrentIndex(int i) {
    _currentLatestNewsIndex = i;
    notifyListeners();
  }

  void setSelectedCategoryName(String value) {
    _selectedCategory = value;
    getCategoryArticles();
    notifyListeners();
  }

  void updateFavouriteArticles(String articles) {
    var objsJson = jsonDecode(articles) as List;
    _favouriteArtilse = objsJson.map((tagJson) => Article.fromJson(tagJson)).toList();
    notifyListeners();
  }

  Future<void> setNextPage(int i) async {
    _currentPage = i;
    await getAllNews();
    notifyListeners();
  }

  Future<void> addOrRemoveFromFavourite(isFavorite, article, User user) async {
    if (isFavorite) {
      _favouriteArtilse.add(article);
    } else {
      _favouriteArtilse.removeWhere(
        (element) => element.title == element.title && element.publishedAt == article.publishedAt,
      );
    }
    User userUpdate = User(
      username: user.username,
      password: user.password,
      email: user.email,
      id: user.id,
      isLoggedIn: false,
      listOfArticles: jsonEncode(_favouriteArtilse),
    );
    await DatabaseHelper.instance.update(userUpdate);
    notifyListeners();
  }

  bool isFavourite(article) {
    var contain = _favouriteArtilse.where(
      (element) => element.title == element.title && element.publishedAt == article.publishedAt,
    );
    return contain.length > 0 ? true : false;
  }
}
