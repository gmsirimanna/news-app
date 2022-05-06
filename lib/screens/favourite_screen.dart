import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:news_app/widgets/custom_app_bar.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/images.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

//Display favourite articles
class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Favourite Articles"),
      body: Consumer<NewsProvider>(builder: (context, newsProvider, child) {
        return Container(
          margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: newsProvider.favouriteArtilse.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: newsProvider.favouriteArtilse.length,
                  shrinkWrap: true,
                  itemBuilder: (context, currentIndex) {
                    return GestureDetector(
                      onTap: (() => Navigator.of(context).pushNamed(
                            "/ArticleDetails",
                            arguments: newsProvider.favouriteArtilse[currentIndex],
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
                                      image: newsProvider.favouriteArtilse[currentIndex].urlToImage,
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
                              child: newsProvider.favouriteArtilse[currentIndex].title != null
                                  ? Text(
                                      newsProvider.favouriteArtilse[currentIndex].title,
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
                              child: newsProvider.favouriteArtilse[currentIndex].content != null
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          newsProvider.favouriteArtilse[currentIndex].content,
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
                                    newsProvider.favouriteArtilse[currentIndex].author != null
                                        ? SizedBox(
                                            width: 50.w,
                                            child: Text(
                                              newsProvider.favouriteArtilse[currentIndex].author,
                                              style: const TextStyle(color: Colors.white, fontSize: Dimensions.FONT_SIZE_SMALL),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    newsProvider.favouriteArtilse[currentIndex].publishedAt != null
                                        ? Text(
                                            newsProvider.favouriteArtilse[currentIndex].publishedAt,
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
                  })
              : Center(
                  child: Text(
                    "NO FAVOURITE ARTICLES FOUND",
                    style: const TextStyle(color: ColorResources.COLOR_GREY, fontSize: Dimensions.FONT_SIZE_LARGE),
                  ),
                ),
        );
      }),
    );
  }
}
