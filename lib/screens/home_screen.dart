import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/widgets/chip_button.dart';
import 'package:news_app/widgets/filter_widget.dart';
import 'package:news_app/widgets/home_widget.dart';
import 'package:news_app/widgets/search_widget.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/search_provider.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/images.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double height, width;
  final textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //call methods after the buld
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      NewsProvider _newsProvider = Provider.of<NewsProvider>(context, listen: false);
      _newsProvider.updateFavouriteArticles(
        Provider.of<AuthProvider>(context, listen: false).user.listOfArticles,
      );
      _newsProvider.getLatestNewsList();
      _newsProvider.getCategoryArticles();
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
          child: Consumer<SearchProvider>(builder: (context, searchProvider, childs) {
            return Column(
              children: [
                //Build Search bar
                _buildTopBar(),

                //Build category chips in search widget (when search click)
                searchProvider.isSearchClicked ? _buildCategoryChips() : SizedBox(),

                //Build search and hot articles when necessary
                searchProvider.isSearchClicked ? SearchWidget() : HomeWidget(),
              ],
            );
          })),
    );
  }

  //Inclass Widjets
  Container _buildTopBar() {
    return Container(
      height: 10.h,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Consumer<SearchProvider>(builder: (context, searchProvider, child) {
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
                      controller: textFieldController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (text) {
                        searchProvider.setSearchKey(text);
                      },
                      decoration: InputDecoration(
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: searchProvider.isSearchClicked
                              ? GestureDetector(
                                  onTap: () {
                                    textFieldController.clear();
                                    searchProvider.clearSearch();
                                  },
                                  child: Icon(Icons.close_rounded))
                              : GestureDetector(
                                  onTap: () => searchProvider.setSearchKey(textFieldController.text),
                                  child: SvgPicture.asset(
                                    Images.search,
                                  ),
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

  Container _buildCategoryChips() {
    SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
    return Container(
        height: 4.5.h,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        margin: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ChipButton(
              title: "Filter",
              icon: Icon(Icons.filter_alt_outlined),
              onClickFunction: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return FilterWidget();
                    });
              },
            ),
            ChipButton(
              title: "Business",
              isFrom: 'fCategory',
              onClickFunction: () {
                _searchProvider.selectedFilterCategoryM("Business");
              },
            ),
            ChipButton(
              title: "Environment",
              isFrom: 'fCategory',
              onClickFunction: () {
                _searchProvider.selectedFilterCategoryM("Environment");
              },
            ),
            ChipButton(
              title: "Health",
              isFrom: 'fCategory',
              onClickFunction: () {
                _searchProvider.selectedFilterCategoryM("Health");
              },
            ),
            ChipButton(
              title: "Science",
              isFrom: 'fCategory',
              onClickFunction: () {
                _searchProvider.selectedFilterCategoryM("Science");
              },
            ),
            ChipButton(
              title: "Sports",
              isFrom: 'fCategory',
              onClickFunction: () {
                _searchProvider.selectedFilterCategoryM("Sports");
              },
            ),
            ChipButton(
              title: "Technology",
              isFrom: 'fCategory',
              onClickFunction: () {
                _searchProvider.selectedFilterCategoryM("Technology");
              },
            ),
            ChipButton(
              title: "Genaral",
              isFrom: 'fCategory',
              onClickFunction: () {
                _searchProvider.selectedFilterCategoryM("Genaral");
              },
            ),
          ],
        ));
  }
}
