import 'package:bangladesh_newspapers/widgets/BoxNewsPaper.dart';
import 'package:bangladesh_newspapers/widgets/MainTabBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final int tab;
  HomeScreen({this.tab, Key key}) : super(key: key);
  // const HomeScreen({
  //   this.tab = 0, // nullable and optional
  // });
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

  double textImageBetweenPadding;
  double textImagePadding;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    gridItem = 2;
    changeGrid();
    tabController = TabController(vsync: this, length: myList.length);

    // tabController = new TabController(
    //     vsync: this, length: myList.length, initialIndex: widget.tab);

    isSelected.add(gridItem == 1);
    isSelected.add(gridItem == 2);
    isSelected.add(gridItem == 3);
    doSomeAsyncStuff();
  }

  void changeGrid() {
    if (gridItem == 1) {
      fontSize = 25;
      childAspectItem = 2;
      boderWidth = 15;
      gridItemSpacing = 10;
      heartFontSize = 30;
      textImageBetweenPadding = 15;
      textImagePadding = 20;
    }
    if (gridItem == 2) {
      fontSize = 15;
      childAspectItem = 1;
      boderWidth = 7;
      gridItemSpacing = 10;
      heartFontSize = 25;
      textImageBetweenPadding = 5;
      textImagePadding = 8;
    }
    if (gridItem == 3) {
      fontSize = 10;
      childAspectItem = 1;
      boderWidth = 3;
      gridItemSpacing = 4;
      heartFontSize = 19;
      textImageBetweenPadding = 2;
      textImagePadding = 4;
    }
  }

  Future<void> doSomeAsyncStuff() async {
    myList = await DataProvider().getAll();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var number = prefs.getInt("gridItem");
    print("tab" + widget.tab.toString());
    //print(myList[0].category);
    setState(() {
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
      tabController = new TabController(
          vsync: this, length: myList.length, initialIndex: 0);

      //tabController.addListener(_handleTabChange);

      //DefaultTabController.of(context).animateTo(widget.tab);

      // tabController.animateTo(_currentTabIndex);
      // _currentTabIndex = widget.tab;
      //tabController.index = widget.tab;
      //super.initState();
    });
    print("before" + widget.tab.toString());
    if (widget.tab > 0) {
      tabController.index = 0;
      await Future.delayed(Duration(milliseconds: 50));
      tabController.index = widget.tab;
      //tabController.animateTo(widget.tab);
      // tabController.index = widget.tab;
      print("after" + widget.tab.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var tabBarItem = TabBar(
      indicatorColor: Colors.black,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black26,
      labelPadding: EdgeInsets.fromLTRB(10.0, 5, 10, 0),
      labelStyle: TextStyle(
          //backgroundColor: Colors.green,
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 15),
      unselectedLabelStyle: TextStyle(
          color: Colors.redAccent, fontWeight: FontWeight.w500, fontSize: 15),
      indicatorWeight: 1,
      isScrollable: true,
      tabs: myList.isEmpty
          ? <Widget>[]
          : myList.map((category) {
              return MainTabBarWidget(category);
            }).toList(),
      controller: tabController,
    );

    return DefaultTabController(
      length: myList.length,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0, 18, 0),
              child: Container(color: Colors.white, child: tabBarItem),
            )),
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
                            color: Colors.white,
                            child: Column(
                              children: [
                                // Expanded(
                                //   flex: 1,
                                //   child: Container(
                                //     margin:
                                //         const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Text(
                                //           category.categoryFullName,
                                //           overflow: TextOverflow.ellipsis,
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.w800,
                                //               fontSize: 20),
                                //         ),
                                //         ToggleButtons(
                                //           borderRadius: BorderRadius.all(
                                //               Radius.circular(15.0)),
                                //           children: <Widget>[
                                //             Icon(FontAwesomeIcons.bars),
                                //             Icon(FontAwesomeIcons.gripVertical),
                                //             Icon(FontAwesomeIcons.th),
                                //           ],
                                //           onPressed: (int index) async {
                                //             SharedPreferences prefs =
                                //                 await SharedPreferences
                                //                     .getInstance();
                                //             prefs.setInt("gridItem", index + 1);
                                //             setState(() {
                                //               gridItem = index + 1;
                                //
                                //               changeGrid();
                                //               for (int buttonIndex = 0;
                                //                   buttonIndex <
                                //                       isSelected.length;
                                //                   buttonIndex++) {
                                //                 if (buttonIndex == index) {
                                //                   isSelected[buttonIndex] =
                                //                       true;
                                //                 } else {
                                //                   isSelected[buttonIndex] =
                                //                       false;
                                //                 }
                                //               }
                                //             });
                                //           },
                                //           isSelected: isSelected,
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
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
                                                : Icons.favorite_border,
                                            "Home",
                                            textImageBetweenPadding,
                                            textImagePadding);
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
        backgroundColor: Color(0xffF9FAFA),
      ),
    );
  }
}
