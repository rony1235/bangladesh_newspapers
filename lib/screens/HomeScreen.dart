import 'package:bangladesh_newspapers/widgets/BoxNewsPaper.dart';
import 'package:bangladesh_newspapers/widgets/MainTabBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController tabController;
  List<DataCategoryModel> myList = List();
  List<bool> isSelected = List();
  int gridItem;
  double childAspectItem;
  double fontSize;
  double boderWidth;
  double gridItemSpacing;
  double heartFontSize;
  Color _iconColor = Colors.white;

  @override
  void initState() {
    super.initState();
    gridItem = 2;
    changeGrid();
    tabController = new TabController(vsync: this, length: myList.length);

    isSelected.add(gridItem == 1);
    isSelected.add(gridItem == 2);
    isSelected.add(gridItem == 3);
    doSomeAsyncStuff();
  }

  void changeGrid() {
    if (gridItem == 1) {
      fontSize = 40;
      childAspectItem = 2;
      boderWidth = 15;
      gridItemSpacing = 10;
      heartFontSize = 30;
    }
    if (gridItem == 2) {
      fontSize = 20;
      childAspectItem = 1;
      boderWidth = 7;
      gridItemSpacing = 10;
      heartFontSize = 25;
    }
    if (gridItem == 3) {
      fontSize = 14;
      childAspectItem = 1;
      boderWidth = 3;
      gridItemSpacing = 4;
      heartFontSize = 19;
    }
  }

  Future<void> doSomeAsyncStuff() async {
    myList = await DataProvider().getAll();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var number = prefs.getInt("gridItem");

    //print(myList[0].category);
    setState(() {
      tabController = new TabController(vsync: this, length: myList.length);
      //print(number);
      if (number == null || number == 0) {
        gridItem = 2;
      } else {
        gridItem = number;
      }
      isSelected = List();
      isSelected.add(gridItem == 1);
      isSelected.add(gridItem == 2);
      isSelected.add(gridItem == 3);
      changeGrid();
    });
  }

  @override
  Widget build(BuildContext context) {
    var tabBarItem = TabBar(
      labelPadding: EdgeInsets.fromLTRB(10.0, 5, 10, 2),
      labelStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20),
      unselectedLabelStyle: TextStyle(
          color: kPrimaryColor, fontWeight: FontWeight.w500, fontSize: 20),
      indicatorWeight: 4.0,
      isScrollable: true,
      tabs: myList.isEmpty
          ? <Widget>[]
          : myList.map((category) {
              return MainTabBarWidget(category);
            }).toList(),
      controller: tabController,
      indicatorColor: kPrimaryLightColor,
    );

    return DefaultTabController(
      length: myList.length,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(color: kPrimaryColor, child: tabBarItem)),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: myList.isEmpty
                      ? <Widget>[]
                      : myList.map((category) {
                          return Container(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          category.categoryFullName,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20),
                                        ),
                                        ToggleButtons(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.bars),
                                            Icon(FontAwesomeIcons.gripVertical),
                                            Icon(FontAwesomeIcons.th),
                                          ],
                                          onPressed: (int index) async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            var number = prefs.setInt(
                                                "gridItem", index + 1);
                                            setState(() {
                                              gridItem = index + 1;

                                              changeGrid();
                                              for (int buttonIndex = 0;
                                                  buttonIndex <
                                                      isSelected.length;
                                                  buttonIndex++) {
                                                if (buttonIndex == index) {
                                                  isSelected[buttonIndex] =
                                                      true;
                                                } else {
                                                  isSelected[buttonIndex] =
                                                      false;
                                                }
                                              }
                                            });
                                          },
                                          isSelected: isSelected,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: GridView.builder(
                                      padding: const EdgeInsets.all(10.0),
                                      itemCount: category.newspaperList.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: gridItem,
                                        crossAxisSpacing: gridItemSpacing,
                                        mainAxisSpacing: gridItemSpacing,
                                        childAspectRatio: childAspectItem,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return BoxNewsPaper(
                                            fontSize,
                                            category.newspaperList[index],
                                            boderWidth,
                                            heartFontSize, () async {
                                          setState(() {
                                            category.newspaperList[index]
                                                    .isFavorite =
                                                !category.newspaperList[index]
                                                    .isFavorite;
                                          });
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          var favoriteList =
                                              prefs.getStringList("Favorite");
                                          if (favoriteList == null) {
                                            favoriteList = List();
                                          }
                                          if (category.newspaperList[index]
                                              .isFavorite) {
                                            favoriteList.add(category
                                                .newspaperList[index].url);
                                          } else {
                                            favoriteList.remove(category
                                                .newspaperList[index].url);
                                          }
                                          //favoriteList = List();
                                          prefs.setStringList(
                                              "Favorite", favoriteList);
                                          //category.newspaperList.removeAt(index);
                                          // favoriteList.forEach((element) {
                                          //   print("test ---" + element);
                                          // });
                                        },
                                            category.newspaperList[index]
                                                    .isFavorite
                                                ? Colors.redAccent
                                                : Colors.black,
                                            category.newspaperList[index]
                                                    .isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border);
                                      }),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: CurvedNavigationBar(
        //   key: _bottomNavigationKey,
        //   index: 0,
        //   height: 50.0,
        //   items: <Widget>[
        //     NavButton(_page, Icons.home, 0, "Home"),
        //     NavButton(_page, Icons.search, 1, "Search"),
        //     NavButton(_page, Icons.favorite, 2, "Favorite"),
        //     NavButton(_page, Icons.settings, 3, "Settings"),
        //     NavButton(_page, Icons.info_outline, 4, "Info"),
        //   ],
        //   color: Colors.white,
        //   buttonBackgroundColor: kPrimaryColor,
        //   backgroundColor: Colors.white,
        //   animationCurve: Curves.easeInOut,
        //   animationDuration: Duration(milliseconds: 600),
        //   onTap: (index) {
        //     setState(() {
        //       _page = index;
        //       print(index);
        //     });
        //   },
        // ),
        backgroundColor: kPrimaryTextColor,
      ),
    );
  }
}
