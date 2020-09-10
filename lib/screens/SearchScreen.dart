import 'package:bangladesh_newspapers/widgets/BoxNewsPaper.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //TabController tabController;
  List<NewspaperList> newspaperList;
  List<NewspaperList> mainNewspaperList;
  List<bool> isSelected = List();
  int gridItem;
  double childAspectItem;
  double fontSize;
  double boderWidth;
  double gridItemSpacing;
  double heartFontSize;
  String textSearch;
  // Color _iconColor = Colors.white;
  // int _page = 0;
  // GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    newspaperList = List();
    gridItem = 2;
    changeGrid();
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
      fontSize = 13;
      childAspectItem = 1;
      boderWidth = 3;
      gridItemSpacing = 4;
      heartFontSize = 19;
    }
  }

  Future<void> doSomeAsyncStuff() async {
    mainNewspaperList = await DataProvider().getAllNewspaper();
    newspaperList = mainNewspaperList;
    setState(() {});
    //print(newspaperList[0].name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: TextField(
                  style: TextStyle(
                    fontSize: 20.0,
                    color: kPrimaryColor,
                  ),
                  cursorColor: kPrimaryColor,
                  onChanged: (value) {
                    //print(value);
                    textSearch = value;
                    //print(newspaperList.length);
                    setState(() {
                      newspaperList = mainNewspaperList
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(textSearch.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                      color: kPrimaryColor,
                    ),
                    hintStyle: TextStyle(color: kPrimaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    ),
                  ),
                )),
          ),
          Expanded(
            flex: 10,
            child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: newspaperList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridItem,
                  crossAxisSpacing: gridItemSpacing,
                  mainAxisSpacing: gridItemSpacing,
                  childAspectRatio: childAspectItem,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return BoxNewsPaper(
                      fontSize, newspaperList[index], boderWidth, heartFontSize,
                      () async {
                    setState(() {
                      newspaperList[index].isFavorite =
                          !newspaperList[index].isFavorite;
                    });
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var favoriteList = prefs.getStringList("Favorite");
                    if (favoriteList == null) {
                      favoriteList = List();
                    }
                    if (newspaperList[index].isFavorite) {
                      favoriteList.add(newspaperList[index].url);
                    } else {
                      favoriteList.remove(newspaperList[index].url);
                    }
                    //favoriteList = List();
                    prefs.setStringList("Favorite", favoriteList);
                    //newspaperList.removeAt(index);
                    // favoriteList.forEach((element) {
                    //   print("test ---" + element);
                    // });
                  },
                      newspaperList[index].isFavorite
                          ? Colors.redAccent
                          : Colors.black,
                      newspaperList[index].isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border);
                }),
          ),
        ],
      )),
      backgroundColor: kGridPrimaryColor,
    );
  }
}
