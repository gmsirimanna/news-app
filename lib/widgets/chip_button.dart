import 'package:flutter/material.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/search_provider.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:provider/provider.dart';

class ChipButton extends StatelessWidget {
  final String title;
  final Function onClickFunction;
  final Widget icon;
  final String isFrom;
  ChipButton({@required this.title, @required this.onClickFunction, this.icon = const SizedBox(), this.isFrom = "home"});

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    if (isFrom == 'home') {
      isSelected = Provider.of<NewsProvider>(context, listen: false).selectedCategory == title ?? false;
    } else if (isFrom == 'filter') {
      isSelected = Provider.of<SearchProvider>(context, listen: false).selectedFilterValue == title ?? false;
    } else if (isFrom == 'fCategory') {
      isSelected = Provider.of<SearchProvider>(context, listen: false).selectedFilterCategory == title ?? false;
    }
    return GestureDetector(
      onTap: onClickFunction,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
        decoration: isSelected
            ? BoxDecoration(
                gradient: ColorResources.PRIMARY_GRADIENT,
                borderRadius: BorderRadius.circular(30.0),
              )
            : BoxDecoration(
                border: Border.all(color: Colors.grey[300]),
                borderRadius: BorderRadius.circular(30.0),
              ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: icon,
            ),
            Text(
              title,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
