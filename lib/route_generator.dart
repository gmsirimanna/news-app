import 'package:flutter/material.dart';
import 'package:news_app/data/model/artical_model.dart';
import 'package:news_app/screens/all_news_screen.dart';
import 'package:news_app/screens/login_page.dart';
import 'package:news_app/screens/main_screen.dart';
import 'package:news_app/screens/news_details_screen.dart';
import 'package:news_app/screens/signup_screen.dart';
import 'package:news_app/screens/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case "/Login":
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case "/Register":
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case "/Main":
        return MaterialPageRoute(builder: (context) => MainScreen());
      case "/SeeAll":
        return MaterialPageRoute(builder: (context) => const AllNewsScreen());
      case "/ArticleDetails":
        ArticleModel item = args as ArticleModel;
        return MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(
                  article: item,
                ));
      default:
      // return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
