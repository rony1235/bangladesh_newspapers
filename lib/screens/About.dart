import 'dart:convert';

import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/models/article.dart';
import 'package:bangladesh_newspapers/screens/webInappwebview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class ScrollScreen extends StatefulWidget {
  @override
  _ScrollScreenState createState() => new _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> {
  //TabController tabController;
  List<Article> articles = List();

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    final String _baseUrl = "sportapi.e2rsoft.com";
    var url = Uri.https(_baseUrl, '/all/bangla');
    //String url = Uri.encodeFull(_baseUrl + 'all/bangla');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        setState(() {
          articles =
              List<Article>.from(l.map((model) => Article.fromJson(model)));
        });
      }
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              itemCount: articles.length,
              shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(), //Optional
              // gridDelegate:
              //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    elevation: 1,
                    color: Colors.white, //kPrimaryCardColor,
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: GestureDetector(
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
                                        url: articles[index].url),
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
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              !(articles[index].urlToImage == null ||
                                      articles[index].urlToImage == "")
                                  ? Stack(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: FadeInImage.assetNetwork(
                                            placeholder: kMainImageLocation +
                                                '1x1_transparent.png',
                                            image: articles[index].urlToImage,
                                            fadeInDuration: const Duration(
                                                milliseconds: 300),
                                            fit: BoxFit.cover,
                                            height: 160,
                                          ),
                                        ),
                                        Positioned(
                                            left: 15,
                                            bottom: 10,
                                            child: Container(
                                              color: Colors.white70,
                                              padding: EdgeInsets.all(5),
                                              child: articles[index]
                                                      .logo
                                                      .contains("svg")
                                                  ? SvgPicture.asset(
                                                      kMainImageLocation +
                                                          articles[index].logo,
                                                      height: 40,
                                                    )
                                                  : Image.asset(
                                                      kMainImageLocation +
                                                          articles[index].logo,
                                                      height: 40,
                                                    ),
                                            )),
                                      ],
                                    )
                                  : Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          15.0, 5, 15, 0),
                                      color: Colors.white70,
                                      child:
                                          articles[index].logo.contains("svg")
                                              ? SvgPicture.asset(
                                                  kMainImageLocation +
                                                      articles[index].logo,
                                                  //width: 40,
                                                  height: 40,
                                                )
                                              : Image.asset(
                                                  kMainImageLocation +
                                                      articles[index].logo,
                                                  //width: 100,
                                                  height: 40,
                                                ),
                                    ),
                              Container(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        articles[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            child: Container(
                                                // We use this Container to create a black box that wraps the white text so that the user can read the text even when the image is white

                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 5),
                                                child: Text(
                                                  "${articles[index].source} | ${articles[index].Date != null ? articles[index].Date : ''}",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 15.0,
                                                    fontFamily: 'Sansnarrow',
                                                  ),
                                                )))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                                articles[index].description,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ));
              }),
        ),
      ),
    );
  }
}
