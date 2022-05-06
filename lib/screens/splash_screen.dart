import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/data/model/user_model.dart';
import 'package:news_app/helper/db_helper.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:news_app/util/images.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    // Check any user still logged in
    Provider.of<AuthProvider>(context, listen: false).isUserLoggedIn().then((value) async {
      if (value.isNotEmpty) {
        User user = await DatabaseHelper.instance.readUserById(int.parse(value));
        if (user != null) Provider.of<AuthProvider>(context, listen: false).saveUser(user);
      }
      Future.delayed(const Duration(seconds: 1), () => _route(value));
    });
  }

  //Router to Main or Signup
  void _route(String val) {
    if (val.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(context, "/Main", (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil("/Login", (route) => false);
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
