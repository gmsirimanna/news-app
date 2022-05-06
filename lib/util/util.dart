import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/util/app_constants.dart';
import 'package:news_app/util/color_resources.dart';

class Util {
  static String convertTime(String time) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(time);
    return DateFormat.yMMMMEEEEd('en_US').format(parseDate);
  }

  static String getImageURL(String url) {
    String returnString = "";
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
}
