import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/screens/favourite_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/profile_screen.dart';
import 'package:news_app/util/color_resources.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;

  final screens = [HomeScreen(), FavouriteScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: GNav(
          backgroundColor: Colors.white,
          rippleColor: Colors.grey[300], // tab button ripple color when pressed
          hoverColor: Colors.grey[300], // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 20,
          tabActiveBorder: null, // tab button border
          tabBorder: null, // tab button border
          tabShadow: null, // tab button shadow
          curve: Curves.easeInToLinear, // tab animation curves
          duration: const Duration(milliseconds: 500), // tab animation duration
          gap: 10, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color
          activeColor: ColorResources.COLOR_PRIMARY_RED, // selected icon and text color
          iconSize: 30, // tab button icon size
          tabBackgroundColor: ColorResources.COLOR_PRIMARY_RED.withOpacity(0.1), // selected tab background color
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favourite',
            ),
            GButton(
              icon: Icons.face,
              text: 'Profile',
            ),
          ],
          selectedIndex: _page,
          onTabChange: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
      ),
      body: IndexedStack(
        index: _page,
        children: screens,
      ),
    );
  }
}
