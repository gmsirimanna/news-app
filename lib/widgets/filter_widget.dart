import 'package:flutter/material.dart';
import 'package:news_app/widgets/chip_button.dart';
import 'package:news_app/providers/search_provider.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/styles.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, searchProvider, childs) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.40,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Filter",
                  style: nunitoBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                  child: ChipButton(
                    title: "Reset",
                    onClickFunction: () {
                      searchProvider.clearFilter();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.delete_forever),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Sort By",
              style: nunitoBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  child: ChipButton(
                    title: "Recommended",
                    isFrom: 'filter',
                    onClickFunction: () {
                      searchProvider.selectedFilter("Recommended");
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ChipButton(
                    title: "Latest",
                    isFrom: 'filter',
                    onClickFunction: () {
                      searchProvider.selectedFilter("Latest");
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  child: ChipButton(
                    title: "Most Viewed",
                    isFrom: 'filter',
                    onClickFunction: () {
                      searchProvider.selectedFilter("Most Viewed");
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ChipButton(
                    title: "Channel",
                    isFrom: 'filter',
                    onClickFunction: () {
                      searchProvider.selectedFilter("Channel");
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: 38.w,
              child: ChipButton(
                title: "Following",
                isFrom: 'filter',
                onClickFunction: () {
                  searchProvider.selectedFilter("Following");
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                searchProvider.filterItems();
                Navigator.pop(context);
              },
              child: Container(
                height: 50.0,
                width: 90.w,
                decoration: BoxDecoration(gradient: ColorResources.PRIMARY_GRADIENT, borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: const Text(
                      'SAVE',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
