import 'package:bangladesh_newspapers/screens/Dashboard.dart';
import 'package:bangladesh_newspapers/screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => new _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  //TabController tabController;
  List<NewspaperList> newspaperList;
  List<bool> isSelected = List();
  int gridItem;

  // Color _iconColor = Colors.white;
  // int _page = 0;
  // GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    newspaperList = List();
    gridItem = 2;

    isSelected.add(gridItem == 1);
    isSelected.add(gridItem == 2);
    isSelected.add(gridItem == 3);
    doSomeAsyncStuff();
  }

  void _close() {
    Navigator.pop(context, true);
    // Navigator.pop(context, gridItem);
  }

  Future<void> doSomeAsyncStuff() async {
    newspaperList = await DataProvider().getAllFavorite();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var number = prefs.getInt("gridItem");
    setState(() {
      print(number);
      if (number == null || number == 0) {
        gridItem = 2;
      } else {
        gridItem = number;
      }
      isSelected = List();
      isSelected.add(gridItem == 1);
      isSelected.add(gridItem == 2);
      isSelected.add(gridItem == 3);
    });

    //print(newspaperList[0].name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "common_assert/logo.png",
                  //height: 38,
                ),
              ),
              ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    Card(
                      color: Colors.white,
                      child: ListTile(
                        focusColor: Colors.redAccent,
                        title: Text(
                          'Email',
                          style: TextStyle(fontSize: 17),
                        ),
                        leading: Icon(
                          Icons.email_outlined,
                          size: 26,
                        ),
                        trailing: Icon(
                          Icons.navigate_next_outlined,
                          size: 26,
                        ),
                        onTap: () async {
                          // Update the state of the app.
                          // ...
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: 'rony01712651412@gmial.com',
                            query:
                                'subject=App Feedback&body=', //add subject and body here
                          );

                          var url = params.toString();
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          'Facebook',
                          style: TextStyle(fontSize: 17),
                        ),
                        leading: Icon(
                          Icons.facebook_outlined,
                          size: 26,
                        ),
                        trailing: Icon(
                          Icons.navigate_next_outlined,
                          size: 26,
                        ),
                        onTap: () async {
                          // Update the state of the app.
                          // ...
                          var url =
                              "https://www.facebook.com/All-Bangla-Newspapers-%E0%A6%B8%E0%A6%95%E0%A6%B2-%E0%A6%AC%E0%A6%BE%E0%A6%82%E0%A6%B2%E0%A6%BE-%E0%A6%B8%E0%A6%82%E0%A6%AC%E0%A6%BE%E0%A6%A6%E0%A6%AA%E0%A6%A4%E0%A7%8D%E0%A6%B0-500-105544607987077";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          'Rate in Google Play',
                          style: TextStyle(fontSize: 17),
                        ),
                        leading: Icon(
                          Icons.favorite_border_outlined,
                          size: 26,
                        ),
                        trailing: Icon(
                          Icons.navigate_next_outlined,
                          size: 26,
                        ),
                        onTap: () async {
                          var url =
                              "https://play.google.com/store/apps/details?id=e2rsoft.com.all_bangla_newspapers";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                          // Update the state of the app.
                          // ...
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          'Share',
                          style: TextStyle(fontSize: 17),
                        ),
                        leading: Icon(
                          Icons.share_outlined,
                          size: 26,
                        ),
                        trailing: Icon(
                          Icons.navigate_next_outlined,
                          size: 26,
                        ),
                        onTap: () {
                          var url =
                              "Download the best app to read newspapers of Bangladesh\n"
                              "https://play.google.com/store/apps/details?id=e2rsoft.com.all_bangla_newspapers";
                          Share.share(url);
                          // Update the state of the app.
                          // ...
                        },
                      ),
                    ),
                  ]),
            ],
          ),
        ),
      ),
      backgroundColor: kGridPrimaryColor,
    );
  }
}
