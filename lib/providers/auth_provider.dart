import 'package:flutter/foundation.dart';
import 'package:news_app/data/model/response/base/api_response.dart';
import 'package:news_app/data/model/response/login_response.dart';
import 'package:news_app/data/repository/auth_repo.dart';
import 'package:news_app/data/repository/response_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({@required this.authRepo});

  // for registration section
  bool _isLoading = false;
  // List<Property> _tenantPropertyList;

  bool get isLoading => _isLoading;
  String _registrationErrorMessage = '';
  // List<Property> get tenantPropertyList => _tenantPropertyList;

  String get registrationErrorMessage => _registrationErrorMessage;

  updateRegistrationErrorMessage(String message) {
    _registrationErrorMessage = message;
    notifyListeners();
  }

  // for login section
  String _loginErrorMessage = '';

  String get loginErrorMessage => _loginErrorMessage;

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.login(email: email, password: password);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      LoginResponse loginResponse = LoginResponse.fromJson(map);
      authRepo.saveUserToken(loginResponse.accessToken);
      authRepo.saveUserData(loginResponse.tenant, email, password);
      responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  String getUserName() {
    return authRepo.getUserName();
  }

  String getMobile() {
    return authRepo.getMobile();
  }

  String getUserImage() {
    return authRepo.getUserImage();
  }
}
