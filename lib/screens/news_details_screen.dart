import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/model/artical_model.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/images.dart';
import 'package:news_app/util/styles.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NewsDetailsScreen extends StatefulWidget {
  Article article;
  NewsDetailsScreen({Key key, @required this.article}) : super(key: key);

  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  double height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print(widget.article.description);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
              child: Stack(
                children: [
                  //Network Image 1 Layer
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    child: SizedBox(
                      height: 41.h,
                      child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder,
                          fit: BoxFit.cover,
                          image: widget.article.urlToImage,
                          imageErrorBuilder: (c, o, s) => Image.asset(
                                Images.placeholder,
                                fit: BoxFit.cover,
                              )),
                    ),
                  ),
                  //White background 2 layer
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 39.h,
                    child: Container(
                        height: 65.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 14.h),
                          child: Text(
                            widget.article.content ?? widget.article.description ?? "",
                            softWrap: true,
                            style: const TextStyle(color: Colors.black, fontSize: Dimensions.FONT_SIZE_DEFAULT, fontWeight: FontWeight.w500),
                          ),
                        )),
                  ),

                  //Grey topic 3 layer
                  Positioned(
                    top: 31.h,
                    left: 9.w,
                    right: 9.w,
                    child: Container(
                        height: 20.h,
                        decoration: const BoxDecoration(
                          gradient: ColorResources.GREY_GRADIENT,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            widget.article.publishedAt != null
                                ? Text(
                                    widget.article.publishedAt,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : SizedBox(),
                            widget.article.title != null
                                ? Text(
                                    widget.article.title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : SizedBox(),
                            widget.article.author != null && widget.article.author.length < 30
                                ? Text(
                                    "Published by ${widget.article.author}",
                                    style: nunitoRegular.copyWith(
                                      color: Colors.black,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : SizedBox(),
                          ],
                        )),
                  ),

                  //Favourite button 4 layer
                  Positioned(
                    top: 50,
                    left: 5,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: FavoriteButton(
                      isFavorite: Provider.of<NewsProvider>(context, listen: false).isFavourite(widget.article),
                      iconColor: ColorResources.COLOR_PRIMARY_RED,
                      valueChanged: (_isFavorite) {
                        Provider.of<NewsProvider>(context, listen: false).addOrRemoveFromFavourite(
                          _isFavorite,
                          widget.article,
                          Provider.of<AuthProvider>(context, listen: false).user,
                        );
                      },
                    ),
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
