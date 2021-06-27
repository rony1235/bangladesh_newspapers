import 'package:bangladesh_newspapers/screens/webInappwebview.dart';
import 'package:bangladesh_newspapers/widgets/BoxNewsPaper.dart';
import 'package:bangladesh_newspapers/widgets/MainTabBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
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

    //print(myList[0].category);
    setState(() {
      //tabController = new TabController(vsync: this, length: myList.length);
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          SizedBox(height: 5.0),
          Container(
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: myList.length,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 26.0,
                      color: kPrimaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(myList[index].categoryFullName,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ],
                      ),
                    ),
                    Container(
                      height: 100.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: myList[index].newspaperList.length,
                        itemBuilder: (context, childIndex) {
                          return GestureDetector(
                            onTap: () {
                              //showAds();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           MyWebTestView(widget.newspaper, widget.page)),
                              // );

                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 0),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return webInappwebview(
                                        NewspaperList(
                                            name: "",
                                            icon: "",
                                            isFavorite: false,
                                            url: myList[index]
                                                .newspaperList[childIndex]
                                                .url),
                                        null);
                                  },
                                  transitionsBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation,
                                      Widget child) {
                                    return Align(
                                      child: FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Stack(children: <Widget>[
                              Image.asset('common_assert/newspaper.png'),
                              Container(
                                height: MediaQuery.of(context).size.width / 4,
                                width: MediaQuery.of(context).size.width / 4,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: myList[index]
                                          .newspaperList[childIndex]
                                          .icon
                                          .contains("svg")
                                      ? SvgPicture.asset(
                                          kMainImageLocation +
                                              myList[index]
                                                  .newspaperList[childIndex]
                                                  .icon,
                                          height: 55,
                                        )
                                      : myList[index]
                                              .newspaperList[childIndex]
                                              .colorFiltered
                                          ? ColorFiltered(
                                              child: Image.asset(
                                                kMainImageLocation +
                                                    myList[index]
                                                        .newspaperList[
                                                            childIndex]
                                                        .icon,
                                                height: 55,
                                              ),
                                              colorFilter: ColorFilter.mode(
                                                  Colors.greenAccent,
                                                  BlendMode.srcIn),
                                            )
                                          : Image.asset(
                                              kMainImageLocation +
                                                  myList[index]
                                                      .newspaperList[childIndex]
                                                      .icon,
                                              height: 55,
                                            ),
                                ),
                              ),
                            ]),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 5.0),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
