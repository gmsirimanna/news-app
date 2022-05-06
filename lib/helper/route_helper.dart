import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/login_page.dart';

class RouteHelper {
  static final FluroRouter router = FluroRouter();

  static String menu = '/Home';
  static String login = '/Rogin';
  static String register = '/Register';
  static String all = '/SeeAll';

  static String getMainRoute() => menu;
  static String getLoginRoute() => login;
  static String getRegisterRoute() => register;

  static final Handler _loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => const LoginPage(),
  );

  static final Handler _registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => const LoginPage(),
  );

  static void setupRouter() {
    router.define(login, handler: _loginHandler, transitionType: TransitionType.fadeIn);
    router.define(login, handler: _registerHandler, transitionType: TransitionType.fadeIn);
  }
}
