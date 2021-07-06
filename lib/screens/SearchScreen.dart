import 'package:bangladesh_newspapers/screens/Dashboard.dart';
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
      gridItemSpacing = 6;
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
      padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
      child: Container(
        child: GridView.builder(
          itemCount: myList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: gridItemSpacing,
            mainAxisSpacing: gridItemSpacing,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print("working");
                print(index);
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 0),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return Dashboard(tab: index);
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
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, -140, rect.width, rect.height - 20));
                  },
                  blendMode: BlendMode.darken,
                  child: Container(
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //   colors: [gradientStart, gradientEnd],
                      //   begin: FractionalOffset(0, 0),
                      //   end: FractionalOffset(0, 1),
                      //   stops: [0.0, 1.0],
                      //   tileMode: TileMode.clamp
                      // ),
                      image: DecorationImage(
                        image:
                            AssetImage("common_assert/" + myList[index].icon),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: ".",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w900)),
                        TextSpan(
                            text: myList[index].categoryFullName.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold)),
                      ]),
                    ))
              ]),
            );

            Column(
              children: <Widget>[
                Container(
                  color: kPrimaryColor,
                  child: GestureDetector(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://placeimg.com/640/480/any"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(myList[index].categoryFullName,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
