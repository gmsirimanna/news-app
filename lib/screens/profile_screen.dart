import 'package:flutter/material.dart';
import 'package:news_app/widgets/custom_app_bar.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:news_app/util/color_resources.dart';
import 'package:news_app/util/dimensions.dart';
import 'package:news_app/util/images.dart';
import 'package:news_app/util/styles.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile Page"),
      body: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircleAvatar(
                  child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      fit: BoxFit.cover,
                      image: "https://fupping.com/wp-content/uploads/2018/06/Personal.png",
                      imageErrorBuilder: (c, o, s) => Image.asset(
                            Images.placeholder,
                            fit: BoxFit.cover,
                          )),
                ),
              ),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            Text(
              'Hi ${authProvider.user.username ?? ""}',
              style: nunitoBold.copyWith(color: Colors.black, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            _detailsRow("User Name : ", authProvider.user.username ?? ""),
            _detailsRow("Email : ", authProvider.user.email ?? ""),
            SizedBox(
              height: 20.0.h,
            ),
            InkWell(
              onTap: () {
                authProvider.clearSharedData();
                Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
              },
              child: Container(
                height: 50.0,
                width: 80.w,
                decoration: BoxDecoration(color: ColorResources.COLOR_PRIMARY_RED, borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_right_alt_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Container _detailsRow(String title, String username) => Container(
        margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: nunitoBold.copyWith(color: Colors.black, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.w500),
            ),
            Text(
              username,
              style: nunitoBold.copyWith(color: Colors.black, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
}
