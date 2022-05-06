import 'package:flutter/foundation.dart';
import 'package:news_app/data/model/artical_model.dart';
import 'package:news_app/data/model/response/base/api_response.dart';
import 'package:news_app/data/model/response/news_response.dart';
import 'package:news_app/data/repository/news_repo.dart';

class SearchProvider with ChangeNotifier {
  final NewsRepo newsRepo;
  SearchProvider({@required this.newsRepo});

  //search variables
  int _currentPage = 1;
  String _searchKey = '';
  String _searchNewsErrorMessage = '';
  List<Article> get searchNewsList => _searchNewsList;
  List<Article> _searchNewsList = [];
  bool _isLoadingSearchNews = false;

  bool _isSearchClicked = false;
  String _selectedFilterValue = "";
  String _selectedFilterCategory = "";

  //getters
  int get currentPage => _currentPage;
  String get searchKey => _searchKey;
  String get searchNewsErrorMessage => _searchNewsErrorMessage;
  bool get isLoadingSearchNews => _isLoadingSearchNews;
  bool get isSearchClicked => _isSearchClicked;
  String get selectedFilterValue => _selectedFilterValue;
  String get selectedFilterCategory => _selectedFilterCategory;

//Filter items according to query text category and filters
  Future<void> filterItems() async {
    _isLoadingSearchNews = true;
    _searchNewsErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await newsRepo.getSearchdArticles(_searchKey, _selectedFilterCategory, _selectedFilterValue, _currentPage);
    NewsResponse latestNewsResponse;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      latestNewsResponse = NewsResponse.fromJson(map);
      _searchNewsList = latestNewsResponse.articles;
    } else {
      _searchNewsList = [];
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      _searchNewsErrorMessage = errorMessage;
    }
    _isLoadingSearchNews = false;
    notifyListeners();
  }

  void clearSearch() {
    _isSearchClicked = false;
    notifyListeners();
  }

  void selectedFilter(String val) {
    _selectedFilterValue = val;
    notifyListeners();
  }

  void setSearchKey(String val) {
    if (val.isNotEmpty) {
      _searchKey = val;
      _isSearchClicked = true;
      filterItems();
    } else
      _isSearchClicked = false;
    notifyListeners();
  }

  void selectedFilterCategoryM(String val) {
    _selectedFilterCategory = val;
    filterItems();
    notifyListeners();
  }

  Future<void> setNextPage(int i) async {
    _currentPage = i;
    filterItems();
    notifyListeners();
  }

  void clearFilter() {
    _selectedFilterCategory = "";
    _selectedFilterValue = "";
    filterItems();
    notifyListeners();
  }
}
