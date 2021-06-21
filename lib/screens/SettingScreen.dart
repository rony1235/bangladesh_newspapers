import 'package:bangladesh_newspapers/screens/Dashboard.dart';
import 'package:bangladesh_newspapers/screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => new _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
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
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Grid",
                    textAlign: TextAlign.center,
                  ),
                  ToggleButtons(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    children: <Widget>[
                      Icon(FontAwesomeIcons.bars),
                      Icon(FontAwesomeIcons.gripVertical),
                      Icon(FontAwesomeIcons.th),
                    ],
                    onPressed: (int index) async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setInt("gridItem", index + 1);
                      print(index + 1);

                      setState(() {
                        gridItem = index + 1;

                        //changeGrid();
                        for (int buttonIndex = 0;
                            buttonIndex < isSelected.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            isSelected[buttonIndex] = true;
                          } else {
                            isSelected[buttonIndex] = false;
                          }
                        }
                      });
                    },
                    isSelected: isSelected,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: kGridPrimaryColor,
    );
  }
}
