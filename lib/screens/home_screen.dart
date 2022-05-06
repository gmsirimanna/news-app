import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/data/model/artical_model.dart';
import 'package:news_app/data/widgets/chip_button.dart';
import 'package:news_app/data/widgets/latest_news_widget.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/images.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double height, width;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      NewsProvider _itemsProvider = Provider.of<NewsProvider>(context, listen: false);
      _itemsProvider.getLatestNewsList();
      _itemsProvider.getCategoryArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  NewsProvider _itemsProvider = Provider.of<NewsProvider>(context, listen: false);
                  _itemsProvider.getLatestNewsList();
                  _itemsProvider.getCategoryArticles();
                },
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Consumer<NewsProvider>(builder: (
                      context,
                      newsProvider,
                      childs,
                    ) {
                      return Column(
                        children: [
                          const LatestNewsWidget(),
                          SizedBox(
                            height: 2.h,
                          ),
                          _buildCategoryChips(),
                          _buildCategoryNews(newsProvider.categoryNewsList, newsProvider.isLoadingCategoryNews, newsProvider.categoryNewsErrorMessage),
                        ],
                      );
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildCategoryNews(List<ArticleModel> _categoryArticles, bool isLoading, String error) {
    return !isLoading && _categoryArticles.isNotEmpty
        ? Container(
            margin: const EdgeInsets.only(right: 15.0, left: 15.0, top: 18),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _categoryArticles.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, currentIndex) {
                  return GestureDetector(
                    onTap: (() => Navigator.of(context).pushNamed(
                          "/ArticleDetails",
                          arguments: _categoryArticles[currentIndex],
                        )),
                    child: Container(
                      width: 90.w,
                      height: 18.h,
                      margin: const EdgeInsets.only(bottom: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 100.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
                                child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder,
                                    fit: BoxFit.cover,
                                    image: _categoryArticles[currentIndex].urlToImage ?? "",
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
                            top: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 3.w,
                            right: 3.w,
                            top: 1.h,
                            child: _categoryArticles[currentIndex].title != null
                                ? Text(
                                    _categoryArticles[currentIndex].title,
                                    style: const TextStyle(color: Colors.white, fontSize: Dimensions.FONT_SIZE_DEFAULT, fontWeight: FontWeight.bold),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          Positioned(
                              left: 3.w,
                              right: 3.w,
                              bottom: 1.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _categoryArticles[currentIndex].author != null
                                      ? SizedBox(
                                          width: 50.w,
                                          child: Text(
                                            _categoryArticles[currentIndex].author,
                                            style: const TextStyle(color: Colors.white, fontSize: Dimensions.FONT_SIZE_SMALL),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  _categoryArticles[currentIndex].publishedAt != null
                                      ? Text(
                                          _categoryArticles[currentIndex].publishedAt,
                                          style: const TextStyle(color: Colors.white, fontSize: Dimensions.FONT_SIZE_SMALL),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                }),
          )
        : Container(
            margin: EdgeInsets.only(top: 10.h),
            child: _categoryArticles.isEmpty && !isLoading
                ? Text(
                    error.isEmpty ? "NO ARTICLES FOUND" : error,
                    style: const TextStyle(color: ColorResources.COLOR_GREY, fontSize: Dimensions.FONT_SIZE_LARGE),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
  }

  Container _buildCategoryChips() {
    NewsProvider _newsProvider = Provider.of<NewsProvider>(context, listen: false);
    return Container(
        height: 4.5.h,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ChipButton(
              title: "Business",
              onClickFunction: () {
                _newsProvider.setSelectedCategoryName("Business");
              },
            ),
            ChipButton(
              title: "Environment",
              onClickFunction: () {
                _newsProvider.setSelectedCategoryName("Environment");
              },
            ),
            ChipButton(
              title: "Health",
              onClickFunction: () {
                _newsProvider.setSelectedCategoryName("Health");
              },
            ),
            ChipButton(
              title: "Science",
              onClickFunction: () {
                _newsProvider.setSelectedCategoryName("Science");
              },
            ),
            ChipButton(
              title: "Sports",
              onClickFunction: () {
                _newsProvider.setSelectedCategoryName("Sports");
              },
            ),
            ChipButton(
              title: "Technology",
              onClickFunction: () {
                _newsProvider.setSelectedCategoryName("Technology");
              },
            ),
            ChipButton(
              title: "Genaral",
              onClickFunction: () {
                _newsProvider.setSelectedCategoryName("Genaral");
              },
            ),
          ],
        ));
  }

  Container _buildTopBar() {
    return Container(
      height: 10.h,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Consumer<NewsProvider>(builder: (context, newsProvider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 15.0),
                    decoration: BoxDecoration(
                      color: HexColor("#F5F8FD"),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: SvgPicture.asset(
                            Images.search,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "Search & Quick Links",
                        hintStyle: TextStyle(
                          color: HexColor("#373D42"),
                        ),
                        contentPadding: const EdgeInsets.only(left: 15.0),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                        color: ColorResources.COLOR_PRIMARY_RED,
                        padding: const EdgeInsets.all(5.0),
                        child: const Icon(
                          Icons.notifications_rounded,
                          color: Colors.white,
                        )))
              ],
            ),
          ],
        );
      }),
    );
  }
}
