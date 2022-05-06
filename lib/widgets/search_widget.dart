import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app/data/model/artical_model.dart';
import 'package:news_app/providers/search_provider.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/images.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key key,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Consumer<SearchProvider>(builder: (context, searchProvider, childs) {
            return Column(
              children: [
                SizedBox(height: 10.0),
                _buildCategoryNews(
                  searchProvider.searchNewsList,
                  searchProvider.isLoadingSearchNews,
                  searchProvider.searchNewsErrorMessage,
                ),
              ],
            );
          })),
    );
  }

  Container _buildCategoryNews(List<Article> _searchArticles, bool isLoading, String error) {
    return !isLoading && _searchArticles.isNotEmpty
        ? Container(
            margin: const EdgeInsets.only(right: 15.0, left: 15.0, top: 18),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _searchArticles.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, currentIndex) {
                  return GestureDetector(
                    onTap: (() => Navigator.of(context).pushNamed(
                          "/ArticleDetails",
                          arguments: _searchArticles[currentIndex],
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
                                    image: _searchArticles[currentIndex].urlToImage,
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
                            child: _searchArticles[currentIndex].title != null
                                ? Text(
                                    _searchArticles[currentIndex].title,
                                    style: const TextStyle(color: Colors.white, fontSize: Dimensions.FONT_SIZE_DEFAULT, fontWeight: FontWeight.bold),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          Positioned(
                            left: 3.w,
                            right: 3.w,
                            top: 7.h,
                            child: _searchArticles[currentIndex].content != null
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _searchArticles[currentIndex].content,
                                        style: const TextStyle(color: Colors.white, fontSize: Dimensions.FONT_SIZE_SMALL, fontWeight: FontWeight.w400),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Read More..",
                                        style: const TextStyle(color: Colors.white70, fontSize: Dimensions.FONT_SIZE_SMALL, fontWeight: FontWeight.w400),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
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
                                  _searchArticles[currentIndex].author != null
                                      ? SizedBox(
                                          width: 50.w,
                                          child: Text(
                                            _searchArticles[currentIndex].author,
                                            style: const TextStyle(color: Colors.white, fontSize: Dimensions.FONT_SIZE_SMALL),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  _searchArticles[currentIndex].publishedAt != null
                                      ? Text(
                                          _searchArticles[currentIndex].publishedAt,
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
            width: 100.w,
            height: 50.h,
            margin: EdgeInsets.only(top: 10.h),
            child: _searchArticles.isEmpty && !isLoading
                ? Center(
                  child: Text(
                      error.isEmpty ? "NO ARTICLES FOUND" : error,
                      style: const TextStyle(color: ColorResources.COLOR_GREY, fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                )
                : const Center(child: CircularProgressIndicator()));
  }
}
