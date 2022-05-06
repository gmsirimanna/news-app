import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/helper/route_helper.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/screens/all_news_screen.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/images.dart';
import 'package:news_app/util/styles.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LatestNewsWidget extends StatefulWidget {
  const LatestNewsWidget({
    Key key,
  }) : super(key: key);

  @override
  State<LatestNewsWidget> createState() => _LatestNewsWidgetState();
}

class _LatestNewsWidgetState extends State<LatestNewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (context, newsProvider, child) {
      int currentIndex = newsProvider.currentLatestNewsIndex;
      int newsLength = newsProvider.latestNewsList.length < 5 ? newsProvider.latestNewsList.length : 10;
      return newsProvider.latestNewsList.isNotEmpty && !newsProvider.isLoadingLatestNews
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.PADDING_SIZE_DEFAULT,
                    right: Dimensions.PADDING_SIZE_DEFAULT,
                    bottom: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Lates News",
                        style: nunitoBold.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(RouteHelper.all, arguments: const AllNewsScreen());
                        },
                        child: const Text(
                          "See All",
                          style: TextStyle(
                            color: ColorResources.COLOR_SECONDARY_BLUE,
                            fontWeight: FontWeight.w700,
                            fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_right)
                    ],
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 30.h,
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.85,
                          aspectRatio: 2.0,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          disableCenter: true,
                          onPageChanged: (index, reason) {
                            newsProvider.setCurrentIndex(index);
                          },
                        ),
                        itemCount: newsLength,
                        itemBuilder: (context, index, _) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                "/ArticleDetails",
                                arguments: newsProvider.latestNewsList[index],
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ImageFiltered(
                                      imageFilter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                                      child: FadeInImage.assetNetwork(
                                          placeholder: Images.placeholder,
                                          fit: BoxFit.cover,
                                          image: newsProvider.latestNewsList[index].urlToImage ?? "",
                                          imageErrorBuilder: (c, o, s) => Image.asset(
                                                Images.placeholder,
                                                fit: BoxFit.cover,
                                              )),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0.h,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withAlpha(70),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 5.w,
                                  right: 5.w,
                                  bottom: 15.8.h,
                                  child: newsProvider.latestNewsList[currentIndex].author != null && newsProvider.latestNewsList[currentIndex].author.length < 20
                                      ? Text(
                                          "by ${newsProvider.latestNewsList[currentIndex].author}",
                                          style: nunitoRegular.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_DEFAULT),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : SizedBox(),
                                ),
                                Positioned(
                                  left: 5.w,
                                  right: 8.w,
                                  bottom: 9.h,
                                  child: newsProvider.latestNewsList[currentIndex].content != null
                                      ? Text(
                                          newsProvider.latestNewsList[currentIndex].title,
                                          style: const TextStyle(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : SizedBox(),
                                ),
                                Positioned(
                                  left: 5.w,
                                  right: 8.w,
                                  bottom: 4.h,
                                  child: newsProvider.latestNewsList[currentIndex].content != null
                                      ? Text(
                                          newsProvider.latestNewsList[currentIndex].content,
                                          style: const TextStyle(color: Colors.white, fontSize: Dimensions.FONT_SIZE_SMALL),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : SizedBox(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Row(
                        children: [
                          const Spacer(),
                          for (int x = 0; x < newsLength; x++) _getBannerDot(x, currentIndex),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Container(
              margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
              child: newsProvider.categoryNewsList.isEmpty && !newsProvider.isLoadingCategoryNews
                  ? Text(
                      newsProvider.categoryNewsErrorMessage.isEmpty ? "NO ARTICLES FOUND" : newsProvider.categoryNewsErrorMessage,
                      style: const TextStyle(color: ColorResources.COLOR_GREY, fontSize: Dimensions.FONT_SIZE_LARGE),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ));
    });
  }

  Container _getBannerDot(int index, int currentIndex) {
    return Container(
      margin: const EdgeInsets.only(right: 4.0, bottom: 8.0),
      width: index == currentIndex ? 5.w : 1.h,
      height: 1.h,
      decoration: BoxDecoration(
        color: index == currentIndex ? Colors.white : Colors.white30,
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
