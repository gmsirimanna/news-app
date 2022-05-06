import 'package:flutter/material.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  CustomAppBar({@required this.title, this.isBackButtonExist = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.COLOR_PRIMARY_RED),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return isBackButtonExist
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                )
              : SizedBox();
        }));
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 60);
}
