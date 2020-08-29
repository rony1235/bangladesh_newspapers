import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:bangladesh_newspapers/screens/web.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController tabController;
  List<DataCategoryModel> myList = List();
  List<bool> isSelected = List();
  int gridItem;
  double childAspectItem;
  double fontSize;
  double boderWidth;
  double gridItemSpacing;

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
    }
    if (gridItem == 2) {
      fontSize = 20;
      childAspectItem = 1;
      boderWidth = 7;
      gridItemSpacing = 10;
    }
    if (gridItem == 3) {
      fontSize = 13;
      childAspectItem = 1;
      boderWidth = 3;
      gridItemSpacing = 4;
    }
  }

  Future<void> doSomeAsyncStuff() async {
    myList = await DataProvider().getAll();
    myList.forEach((data) {
      data.newspaperList.forEach((element) {
        element.isFavorite = false;
      });
    });
    print(myList[0].category);
    setState(() {
      tabController = new TabController(vsync: this, length: myList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    var tabBarItem = TabBar(
      labelPadding: EdgeInsets.fromLTRB(10.0, 5, 10, 2),
      labelStyle: TextStyle(
          color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 20),
      unselectedLabelStyle:
          TextStyle(color: Color(0xffacb3bf), fontWeight: FontWeight.w500),
      indicatorWeight: 4.0,
      isScrollable: true,
      tabs: myList.isEmpty
          ? <Widget>[]
          : myList.map((category) {
              return MainTabBarWidget(category);
            }).toList(),
      controller: tabController,
      indicatorColor: Color(0xff407473),
    );

    return DefaultTabController(
      length: myList.length,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            bottom: tabBarItem,
            shadowColor: Color(0xff407473),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bangladesh Newspaper",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 35),
              ),
            ),
            centerTitle: true,
          ),
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
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 5, 15, 5),
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
                                              Icon(FontAwesomeIcons
                                                  .gripVertical),
                                              Icon(FontAwesomeIcons.th),
                                            ],
                                            onPressed: (int index) {
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
                                        itemCount:
                                            category.newspaperList.length,
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
                                              boderWidth);
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
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class BoxNewsPaper extends StatefulWidget {
  final NewspaperList newspaper;
  final double fontSize;
  final double boderWidth;
  BoxNewsPaper(@required this.fontSize, @required this.newspaper,
      @required this.boderWidth);

  @override
  _BoxNewsPaperState createState() => _BoxNewsPaperState();
}

class _BoxNewsPaperState extends State<BoxNewsPaper> {
  Color _iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 2.0,
        color: Color(0xffE6FCFC),
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(
                        color: Color(0xff407473), width: widget.boderWidth))),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: 'imageHero${widget.newspaper.icon}',
                      child: Image.asset(
                        "images/${widget.newspaper.icon}",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          widget.newspaper.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(FontAwesomeIcons.solidHeart,
                                  color: widget.newspaper.isFavorite
                                      ? _iconColor
                                      : Colors.redAccent),
                              onPressed: () {
                                setState(() {
                                  widget.newspaper.isFavorite =
                                      !widget.newspaper.isFavorite;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1000),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return MyWebView(widget.newspaper);
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
    );
  }
}

class MainTabBarWidget extends StatelessWidget {
  final DataCategoryModel category;
  MainTabBarWidget(
    this.category,
  );

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        child: Text(category.category),
      ),
    );
  }
}
