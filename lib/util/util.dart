import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:news_app/util/app_constants.dart';
import 'package:news_app/util/color_resources.dart';

class Util {
  static String getImageURL(String url) {
    if (url == null) return AppConstants.PLACEHOLDER;
    if (url.contains("http")) return url;
    return "https:${url}";
  }

  static void showBotToast(String message, BuildContext context, {bool isError = true}) {
    BotToast.showSimpleNotification(
        title: message,
        titleStyle: TextStyle(color: Colors.white),
        backgroundColor: isError ? ColorResources.COLOR_PRIMARY_RED : Colors.green,
        duration: Duration(milliseconds: 1500),
        hideCloseButton: true);
  }

  static bool isNotValid(String email) {
    return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
