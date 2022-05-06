import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/data/repository/auth_repo.dart';
import 'package:news_app/util/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences _prefs;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPrefs());
  }

  initPrefs() async {
    Future.delayed(const Duration(seconds: 1), () => _route());
  }

  void _route() {
    AuthRepo repo = AuthRepo(dioClient: GetIt.instance(), sharedPreferences: GetIt.instance());
    String token = repo.getUserToken();
    if (token.isEmpty) {
      // Navigator.of(context).pushNamedAndRemoveUntil("/Login", (route) => false);
      Navigator.pushNamedAndRemoveUntil(context, "/Main", (route) => false);
    } else {
      repo.updateToken(token);
      // Navigator.of(context).pushNamedAndRemoveUntil("/Home", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Image.asset(
                          Images.newsAppTitle,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
