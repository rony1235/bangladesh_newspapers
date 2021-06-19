import 'dart:async';

import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/models/article.dart';
import 'package:bangladesh_newspapers/screens/webInappwebview.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef void FlipBack({bool backToTop});

class ArticlePage extends StatefulWidget {
  final Article article;

  final FlipBack flipBack;

  final double height;

  ArticlePage(this.article, this.flipBack, this.height);

  @override
  ArticlePageState createState() {
    return new ArticlePageState();
  }
}

class ArticlePageState extends State<ArticlePage> {
  Future<Null> _selectSources(BuildContext context) async {
    // String result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => SourcesPage(ArticleBlocProvider.of(context))),
    // );
    // if (result == null) {
    //   ArticleBlocProvider.of(context).getArticles(refresh: true);
    // }
  }

  Future<Null> _aboutPage(BuildContext context) async {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => AboutPage()));
  }

  _launchURL() async {
    String url = widget.article.url;
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1400),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return webInappwebview(
              NewspaperList(name: "", icon: "", isFavorite: false, url: url),
              null);
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );

    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   Scaffold.of(context)
    //       .showSnackBar(SnackBar(content: Text("Could not launch $url")));
    // }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    Icon _getMenuIcon(TargetPlatform platform) {
      assert(platform != null);
      switch (platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return const Icon(Icons.more_horiz);
        default:
          return const Icon(Icons.more_vert);
      }
    }

    Icon _getBackIcon(TargetPlatform platform) {
      assert(platform != null);
      switch (platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return const Icon(Icons.arrow_back_ios);
        default:
          return const Icon(Icons.arrow_back);
      }
    }

    return Container(
      color: Colors.white,
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      child: WillPopScope(
        onWillPop: () {
          return new Future(() {
            if (widget.flipBack == null) return true;
            widget.flipBack();
            return false;
          });
        },
        child: Scaffold(
          // appBar: AppBar(
          //   leading: widget.flipBack != null
          //       ? new IconButton(
          //           icon: _getBackIcon(Theme.of(context).platform),
          //           color: Colors.black87,
          //           onPressed: widget.flipBack,
          //         )
          //       : Padding(
          //           padding: const EdgeInsets.all(10.0),
          //           child: Image.asset(
          //             kMainImageLocation + 'flutboard_logo.png',
          //           ),
          //         ),
          //   title: widget.article.logo.contains("svg")
          //       ? SvgPicture.asset(
          //           kMainImageLocation + widget.article.logo,
          //           fit: BoxFit.contain,
          //           height: 30,
          //         )
          //       : Image.asset(
          //           kMainImageLocation + widget.article.logo,
          //           fit: BoxFit.contain,
          //           height: 30,
          //         ),
          //   elevation: 0.0,
          //   centerTitle: true,
          //   actions: <Widget>[
          //     widget.flipBack == null
          //         ? IconButton(
          //             icon: new Icon(Icons.refresh),
          //             //color: Colors.black87,
          //             // onPressed: () => ArticleBlocProvider.of(context)
          //             //     .getArticles(refresh: true),
          //           )
          //         : IconButton(
          //             icon: Icon(Icons.arrow_upward),
          //             onPressed: () {
          //               widget.flipBack(backToTop: true);
          //             })
          //
          //     // PopupMenuButton<String>(
          //     //   itemBuilder: (BuildContext context) {
          //     //     return <PopupMenuEntry<String>>[
          //     //       widget.flipBack == null
          //     //           ? null
          //     //           // ? PopupMenuItem<String>(
          //     //           //     value: 'sources',
          //     //           //     child: Text('Select Sources'),
          //     //           //   )
          //     //           : PopupMenuItem<String>(
          //     //               value: 'back',
          //     //               child: Text('Back to Top'),
          //     //             ),
          //     //       // PopupMenuItem<String>(
          //     //       //   value: 'about',
          //     //       //   child: Text('About'),
          //     //       // ),
          //     //     ];
          //     //   },
          //     //   onSelected: (String value) {
          //     //     if (value == 'back') {
          //     //       widget.flipBack(backToTop: true);
          //     //     }
          //     //     if (value == 'sources') {
          //     //       _selectSources(context);
          //     //     }
          //     //     if (value == 'about') {
          //     //       _aboutPage(context);
          //     //     }
          //     //   },
          //     // ),
          //   ],
          // ),
          body: GestureDetector(
            onTap: _launchURL,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: screenWidth,
                  child: widget.article.urlToImage != null &&
                          widget.article.urlToImage.trim() != ""
                      ? Stack(
                          children: [
                            FadeInImage.assetNetwork(
                              placeholder:
                                  kMainImageLocation + '1x1_transparent.png',
                              image: widget.article.urlToImage,
                              width: screenWidth,
                              height: screenWidth / 2,
                              fadeInDuration: const Duration(milliseconds: 300),
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              left: 15,
                              bottom: 10,
                              child: widget.article.Date != null &&
                                      widget.article.Date.trim() != ""
                                  ? Container(
                                      // We use this Container to create a black box that wraps the white text so that the user can read the text even when the image is white

                                      color: kPrimaryColor,
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        widget.article.Date,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontFamily: 'Sansnarrow',
                                        ),
                                      ))
                                  : Container(),
                            ),
                            Positioned(
                                right: 15,
                                bottom: 10,
                                child: Container(
                                  color: Colors.white70,
                                  padding: EdgeInsets.all(5),
                                  child: widget.article.logo.contains("svg")
                                      ? SvgPicture.asset(
                                          kMainImageLocation +
                                              widget.article.logo,
                                          height: 40,
                                        )
                                      : Image.asset(
                                          kMainImageLocation +
                                              widget.article.logo,
                                          height: 40,
                                        ),
                                )),
                          ],
                        )
                      : Container(),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 12, 15, 0),
                  child: Text(
                    widget.article.title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 5, 15, 0),
                  child: Text(
                    // Be sure
                    widget.article.source,
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                ),
                Expanded(
                  child: widget.article.description != null &&
                          widget.article.description.trim() != ""
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 10, 15, 0),
                          child: LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            var maxLines =
                                ((constraints.maxHeight / 18.0).floor() - 1);
                            return maxLines > 0
                                ? Text(
                                    widget.article.description,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black87),
                                    maxLines: maxLines,
                                  )
                                : Container();
                          }),
                        )
                      : Container(),
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: <Widget>[
                //     Expanded(child: Container()),
                //     IconButton(
                //       icon: Icon(Icons.favorite_border),
                //       onPressed: null,
                //     ),
                //     IconButton(
                //       icon: Icon(Icons.add),
                //       onPressed: null,
                //     ),
                //     IconButton(
                //       icon: _getMenuIcon(Theme.of(context).platform),
                //       onPressed: null,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
