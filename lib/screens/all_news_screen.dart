import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/data/model/artical_model.dart';
import 'package:news_app/data/repository/exception/empty_list_indicator.dart';
import 'package:news_app/data/repository/exception/error_indicator.dart';
import 'package:news_app/widgets/custom_app_bar.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/images.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AllNewsScreen extends StatefulWidget {
  const AllNewsScreen({Key key}) : super(key: key);

  @override
  _AllNewsScreenState createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  double height, width;
  //Paginate controller
  final PagingController<int, Article> _pagingController = PagingController(firstPageKey: 1);

  //initiate pagination
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  //paginate fetch method
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      await newsProvider.setNextPage(pageKey);

      //check if its the last page
      final newPage = newsProvider.allNewsList;
      final isLastPage = newPage.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(newPage);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newPage, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Hot Updates",
        isBackButtonExist: true,
      ),
      body: Consumer<NewsProvider>(builder: (context, newsProvider, child) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            //pull to refresh
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => _pagingController.refresh(),
              ),
              child: PagedListView.separated(
                // 4
                builderDelegate: PagedChildBuilderDelegate<Article>(
                  itemBuilder: (context, article, currentIndex) {
                    return GestureDetector(
                      onTap: (() => Navigator.of(context).pushNamed(
                            "/ArticleDetails",
                            arguments: article,
                          )),
                      child: Container(
                        width: 90.w,
                        margin: const EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100.w,
                              height: 15.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder,
                                    fit: BoxFit.cover,
                                    image: article.urlToImage ?? "",
                                    imageErrorBuilder: (c, o, s) => Image.asset(
                                          Images.placeholder,
                                          fit: BoxFit.cover,
                                        )),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            article.publishedAt != null
                                ? Text(
                                    article.publishedAt,
                                    style: const TextStyle(color: Colors.black, fontSize: Dimensions.FONT_SIZE_SMALL),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 8.0,
                            ),
                            article.title != null
                                ? Text(
                                    article.title,
                                    style: const TextStyle(color: Colors.black, fontSize: Dimensions.FONT_SIZE_DEFAULT, fontWeight: FontWeight.bold),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 8.0,
                            ),
                            article.content != null
                                ? Text(
                                    article.content,
                                    style: const TextStyle(color: Colors.black, fontSize: Dimensions.FONT_SIZE_SMALL),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const SizedBox.shrink(),
                            const Text(
                              "Read more",
                              style: TextStyle(color: ColorResources.COLOR_SECONDARY_BLUE, fontSize: Dimensions.FONT_SIZE_DEFAULT),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            article.author != null
                                ? Text(
                                    'Published by ${article.author}',
                                    style: const TextStyle(color: Colors.black, fontSize: Dimensions.FONT_SIZE_SMALL),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
                    error: _pagingController.error,
                    onTryAgain: () => _pagingController.refresh(),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(),
                ),

                pagingController: _pagingController,
                padding: const EdgeInsets.all(8),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 1,
                ),
              ),
            ));
      }),
    );
  }
}
