import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/screens/webInappwebview.dart';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSearch extends SearchDelegate<NewspaperList> {
  final BuildContext parentContext;

  //final Logger logger = new Logger();

  DataSearch(this.parentContext);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query.isEmpty
          ? DataProvider().getAllNewspaper()
          : DataProvider().getAllNewspaperByName(query),
      builder: (context, AsyncSnapshot<List<NewspaperList>> snapshot) {
        print("AsyncSnapshot<List<NewspaperList>> snapshot");
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data[0].name);
          //logger.d(snapshot.hasData);
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: SizedBox(
                  height: 35.0,
                  width: 75.0, // fixed width and height
                  child: snapshot.data[index].icon.contains("svg")
                      ? SvgPicture.asset(
                          kMainImageLocation + snapshot.data[index].icon,
                        )
                      : snapshot.data[index].colorFiltered
                          ? ColorFiltered(
                              child: Image.asset(
                                kMainImageLocation + snapshot.data[index].icon,
                              ),
                              colorFilter: ColorFilter.mode(
                                  Colors.greenAccent, BlendMode.srcIn),
                            )
                          : Image.asset(
                              kMainImageLocation + snapshot.data[index].icon,
                            ),
                ),
                title: Text(snapshot.data[index].name),
                trailing: GestureDetector(
                    child: Icon(
                        snapshot.data[index].isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 20,
                        color: snapshot.data[index].isFavorite
                            ? Colors.redAccent
                            : Colors.black),
                    onTap: () async {
                      print("sddsd");
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var favoriteList = prefs.getStringList("Favorite");
                      if (favoriteList == null) {
                        favoriteList = List();
                      }
                      print(snapshot.data[index].url);
                      print(snapshot.data[index].url);
                      if (!snapshot.data[index].isFavorite) {
                        print(snapshot.data[index].url);
                        favoriteList.add(snapshot.data[index].url);
                      } else {
                        favoriteList.remove(snapshot.data[index].url);
                      }
                      //favoriteList = List();
                      prefs.setStringList("Favorite", favoriteList);

                      //newspaperList.removeAt(index);
                      // favoriteList.forEach((element) {
                      //   print("test ---" + element);
                      // });
                    }),
                onTap: () {
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
                                url: snapshot.data[index].url),
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
                  //close(context, snapshot.data[index]);
                },
              );
            },
            itemCount: snapshot.data.length, // data is null
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
