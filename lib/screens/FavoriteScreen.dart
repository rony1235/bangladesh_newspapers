import 'package:bangladesh_newspapers/widgets/BoxNewsPaper.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => new _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with TickerProviderStateMixin {
  //TabController tabController;
  List<NewspaperList> newspaperList;
  List<bool> isSelected = List();
  int gridItem;
  double childAspectItem;
  double fontSize;
  double boderWidth;
  double gridItemSpacing;
  double heartFontSize;
  double textImageBetweenPadding;
  double textImagePadding;
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
      fontSize = 30;
      childAspectItem = 2;
      boderWidth = 15;
      gridItemSpacing = 10;
      heartFontSize = 30;
      textImageBetweenPadding = 8;
      textImagePadding = 8;
    }
    if (gridItem == 2) {
      fontSize = 15;
      childAspectItem = 1;
      boderWidth = 7;
      gridItemSpacing = 10;
      heartFontSize = 25;
      textImageBetweenPadding = 8;
      textImagePadding = 8;
    }
    if (gridItem == 3) {
      fontSize = 11;
      childAspectItem = 1;
      boderWidth = 3;
      gridItemSpacing = 4;
      heartFontSize = 19;
      textImageBetweenPadding = 8;
      textImagePadding = 8;
    }
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
      changeGrid();
    });

    //print(newspaperList[0].name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Container(
        child: Column(
          children: [
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
                    return BoxNewsPaper(fontSize, newspaperList[index],
                        boderWidth, heartFontSize, () async {
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
                      newspaperList.removeAt(index);
                      // favoriteList.forEach((element) {
                      //   print("test ---" + element);
                      // });
                    },
                        newspaperList[index].isFavorite
                            ? Colors.redAccent
                            : Colors.black,
                        newspaperList[index].isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        "Fav",
                        textImageBetweenPadding,
                        textImagePadding);
                  }),
            ),
          ],
        ),
      )),
      backgroundColor: kBackGroundPrimaryColor,
    );
  }
}
