import 'package:bangladesh_newspapers/screens/FavoriteScreen.dart';
import 'package:bangladesh_newspapers/widgets/NavButton.dart';

import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'About.dart';
import 'HomeScreen.dart';
import 'SearchScreen.dart';
import 'Setting.dart';

class Dashboard extends StatefulWidget {
  static final String id = 'profile_page';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PageController _pageController;

  // ignore: non_constant_identifier_names
  int _Page = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: kPrimaryColor,
          title: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "Bangladesh Newspaper",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 35),
            ),
          ),
          centerTitle: true,
        ),
        body: PageView(
            controller: _pageController,
            children: <Widget>[
              HomeScreen(),
              SearchScreen(),
              FavoriteScreen(),
              SettingScreen(),
              AboutScreen(),
            ],
            onPageChanged: (int index) {
              setState(() {
                _pageController.jumpToPage(index);
              });
            }),
        bottomNavigationBar: CurvedNavigationBar(
          //animationCurve: Curves.easeInOutBack,
          index: 0,
          items: <Widget>[
            NavButton(_Page, Icons.home, 0, "Home"),
            NavButton(_Page, Icons.search, 1, "Search"),
            NavButton(_Page, Icons.favorite, 2, "Favorite"),
            NavButton(_Page, Icons.settings, 3, "Settings"),
            NavButton(_Page, Icons.info_outline, 4, "Info"),
          ],
          color: Colors.white,
          buttonBackgroundColor: kPrimaryColor,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          height: 50.0,
          onTap: (int index) {
            setState(() {
              _Page = index;
              _pageController.jumpToPage(index);
            });
          },
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
