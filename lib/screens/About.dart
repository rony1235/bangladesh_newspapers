import 'dart:convert';

import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/models/article.dart';
import 'package:bangladesh_newspapers/screens/webInappwebview.dart';
import 'package:bangladesh_newspapers/services/api.dart';
import 'package:bangladesh_newspapers/services/article_bloc.dart';
import 'package:bangladesh_newspapers/services/article_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:flutter_svg/svg.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => new _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  //TabController tabController;
  List<Article> articles = List();

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    Api api = new Api();
    ArticleBloc bloc = ArticleBloc(api: api);

    bloc.getArticles();
    articles = await bloc.articles.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: articles.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 3,
                  color: Colors.white, //kPrimaryCardColor,
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 1400),
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
                        color: Color(0xffF8F8F8),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 15,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: FadeInImage.assetNetwork(
                                  placeholder: kMainImageLocation +
                                      '1x1_transparent.png',
                                  image: articles[index].urlToImage,
                                  fadeInDuration:
                                      const Duration(milliseconds: 300),
                                  fit: BoxFit.cover,
                                  height: 250.0,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 15,
                              child: Container(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        articles[index].title,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: Text(articles[index].description,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: articles[index]
                                                  .logo
                                                  .contains("svg")
                                              ? SvgPicture.asset(
                                                  kMainImageLocation +
                                                      articles[index].logo,
                                                )
                                              : Image.asset(
                                                  kMainImageLocation +
                                                      articles[index].logo,
                                                ),
                                        ),
                                        Container(
                                          child: articles[index].Date != null &&
                                                  articles[index].Date.trim() !=
                                                      ""
                                              ? Container(
                                                  // We use this Container to create a black box that wraps the white text so that the user can read the text even when the image is white

                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    articles[index].Date,
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 15.0,
                                                      fontFamily: 'Sansnarrow',
                                                    ),
                                                  ))
                                              : Container(),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
            }),
      ),
    );
  }
}
