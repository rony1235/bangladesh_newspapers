import 'dart:async';
import 'dart:math';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
//import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String testDevice = 'F6836817538F494C0544BC912D578A82';
const int ShowAdsNumber = 5;

// ignore: must_be_immutable
class webInappwebview extends StatefulWidget {
  final NewspaperList newspaper;
  final String page;

  webInappwebview(this.newspaper, this.page) {
    //print("http://foo.com/bar.html");
    // showAds();
  }

  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //     testDevices: testDevice != null ? <String>[testDevice] : null,
  //     keywords: <String>['game', 'newspaper'],
  //     //contentUrl: 'https://flutter.io',
  //     //birthday: DateTime.now(),
  //     childDirected: false,
  //     nonPersonalizedAds: false
  //     //designedForFamilies: false,
  //     //gender: MobileAdGender.male,
  //     );

  @override
  _webInappwebviewState createState() => _webInappwebviewState();
}

class _webInappwebviewState extends State<webInappwebview> {
  final _key = UniqueKey();

  bool showAppBar = false;
  List<NewspaperList> list;

  List<String> placementId = [
    "306255247337644_409115817051586",
    "306255247337644_409116020384899",
    "306255247337644_409116240384877",
    "306255247337644_409116613718173",
    "306255247337644_409116883718146",
    "306255247337644_409117090384792",
    "306255247337644_409117573718077",
    "306255247337644_409117747051393",
    "306255247337644_409118057051362",
    "306255247337644_409118233718011"
  ];
  //bool _isAppbar = true;

  InAppWebViewController controller;

  String url = "";

  double progress = 0;
  //int postY = 0;
  //ScrollController _scrollController = new ScrollController();

  void initState() {
    //super.initState();
    //FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);

    // FirebaseAdMob.instance
    //     .initialize(appId: "ca-app-pub-4471555289018876~9616924043");

    FacebookAudienceNetwork.init(
        //testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
        );
    getData();
    // RewaardedVideoAd.instance.listener =
    //     (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
    //   print("RewardedVideoAd event $event");
    //   if (event == RewardedVideoAdEvent.rewarded) {
    //     print("rewardAmount" + rewardAmount.toString());
    //   }
    // };
  }

  Future<void> getData() async {
    list = await DataProvider().getAllNewspaper();
    setState(() {});
  }

  Future<void> showAds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var number = prefs.getInt("paperVisit");
    if (number == null) {
      prefs.setInt("paperVisit", 0);
    } else {
      // print("paperVisit" + number.toString());
      try {
        if (number == ShowAdsNumber - 1) {
          // RewardedVideoAd.instance
          //     .load(
          //         adUnitId: "ca-app-pub-4471555289018876/1165255741",
          //         //RewardedVideoAd.testAdUnitId,
          //         targetingInfo: webInappwebview.targetingInfo)
          //     .catchError((e) => print('Error in loading.'));
          // ;
          prefs.setInt("paperVisit", number + 1);
        } else if (number >= ShowAdsNumber) {
          prefs.setInt("paperVisit", 0);
          try {
            // await RewardedVideoAd.instance
            //     .show()
            //     .catchError((e) => print('Error in loading.'));
            // ;
          } on PlatformException catch (e) {}
        } else {
          prefs.setInt("paperVisit", number + 1);
        }
      } catch (e) {}
    }
  }

  // BannerAd myBanner = BannerAd(
  //   // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  //   // https://developers.google.com/admob/android/test-ads
  //   // https://developers.google.com/admob/ios/test-ads
  //   adUnitId: //BannerAd.testAdUnitId,
  //       "ca-app-pub-4471555289018876/7187757128", // "ca-app-pub-2877215416565320/1305026042", //BannerAd.testAdUnitId,
  //   size: AdSize.banner,
  //   targetingInfo: webInappwebview.targetingInfo,
  //
  //   listener: (MobileAdEvent event) {
  //     print("BannerAd event is $event");
  //   },
  // );

  Future<void> dispose() async {
    print("myBanner?.dispose()");
    //await controller..close();
    //controller.dispose();
    //super.dispose();
    //myBanner?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Random rnd;
    int min = 0;
    int max = placementId.length - 1;
    rnd = new Random();
    var r = min + rnd.nextInt(max - min);
    var mainPlacementId = placementId[r];
    //controllerGlobal = _controller;
    // myBanner
    //   // typically this happens well before the ad is shown
    //   ..load()
    //   ..show(
    //     // Positions the banner ad 60 pixels from the bottom of the screen
    //     anchorOffset: 10.0,
    //     // Positions the banner ad 10 pixels from the center of the screen to the right
    //     horizontalCenterOffset: 10.0,
    //     // Banner Position
    //     anchorType: AnchorType.bottom,
    //   );
    return WillPopScope(
      onWillPop: () async {
        //print("bef");
        try {
          var status = await controller.canGoBack();
          print("status" + status.toString());
          if (status) {
            controller.goBack();
            return false;
          } else {
            //flutterWebviewPlugin.close();
            //await controller.close();
            //controller.dispose();
            //await FlutterWebviewPlugin().close();
            // if (!await myBanner.isLoaded()) {
            //   //print("test");
            //   Timer(const Duration(seconds: 2), () async {
            //     if (!await myBanner.isLoaded()) {
            //       Timer(const Duration(seconds: 6), () {
            //         myBanner?.dispose();
            //       });
            //     } else {
            //       myBanner?.dispose();
            //     }
            //   });
            //   //print("dsd");
            // } else {
            //   myBanner?.dispose();
            // }
            return true;
          }
        } catch (e) {
          //print("ddd" + e.toString());
          //await controller.close();
          //controller.dispose();
          //print(e);
          return true;

          //print(e);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 35,
              backgroundColor: Colors.white,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                      icon: Icon(
                        Icons.menu_rounded,
                        color: Colors.black54,
                        size: 30.0,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer());
                },
              ),
              title: Image.asset(
                "common_assert/logo.png",
                height: 38,
              ),
              centerTitle: true,
              elevation: 0,
            ),
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: SafeArea(
                  child: FutureBuilder(
                future: DataProvider().getAllNewspaper(),
                builder:
                    (context, AsyncSnapshot<List<NewspaperList>> snapshot) {
                  print("AsyncSnapshot<List<NewspaperList>> snapshot");
                  if (snapshot.connectionState == ConnectionState.done) {
                    print(snapshot.data[0].name);
                    //logger.d(snapshot.hasData);
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            controller.loadUrl(url: snapshot.data[index].url);
                            Scaffold.of(context).openEndDrawer();
                          },
                          leading: SizedBox(
                            height: 35.0,
                            width: 75.0, // fixed width and height
                            child: snapshot.data[index].icon.contains("svg")
                                ? SvgPicture.asset(
                                    kMainImageLocation +
                                        snapshot.data[index].icon,
                                  )
                                : snapshot.data[index].colorFiltered
                                    ? ColorFiltered(
                                        child: Image.asset(
                                          kMainImageLocation +
                                              snapshot.data[index].icon,
                                        ),
                                        colorFilter: ColorFilter.mode(
                                            Colors.greenAccent,
                                            BlendMode.srcIn),
                                      )
                                    : Image.asset(
                                        kMainImageLocation +
                                            snapshot.data[index].icon,
                                      ),
                          ),
                          title: Text(snapshot.data[index].name),
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
              )),
            ),
            // appBar: PreferredSize(
            //   preferredSize: Size.fromHeight(kToolbarHeight),
            //   child: AnimatedContainer(
            //     height: _isAppbar ? 55.0 : 0.0,
            //     duration: Duration(milliseconds: 200),
            //     child: CustomAppBar(),
            //   ),
            // ),
            // appBar: showAppBar
            //     ? AppBar(
            //         backgroundColor: Colors.white,
            //         flexibleSpace: SafeArea(
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Container(
            //               child: Hero(
            //                 tag: '${widget.page}imageHero${widget.newspaper.url}',
            //                 child: widget.newspaper.icon.contains("svg")
            //                     ? SvgPicture.asset(
            //                         "images/${widget.newspaper.icon}",
            //                         fit: BoxFit.contain,
            //                         height: 30,
            //                       )
            //                     : Image.asset(
            //                         "images/${widget.newspaper.icon}",
            //                         fit: BoxFit.contain,
            //                         height: 30,
            //                       ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         centerTitle: true,
            //         leading: BackButton(
            //             color: Colors.black,
            //             onPressed: () async {
            //               // print("bef");
            //               try {
            //                 var status = await controller.canGoBack();
            //                 print("status" + status.toString());
            //                 if (status) {
            //                   controller.goBack();
            //                 } else {
            //                   //await controller.close();
            //                   //controller.dispose();
            //
            //                   if (!await myBanner.isLoaded()) {
            //                     //print("test");
            //                     Timer(const Duration(seconds: 2), () async {
            //                       if (!await myBanner.isLoaded()) {
            //                         Timer(const Duration(seconds: 6), () {
            //                           myBanner?.dispose();
            //                         });
            //                       } else {
            //                         myBanner?.dispose();
            //                       }
            //                     });
            //                     //print("dsd");
            //                   } else {
            //                     myBanner?.dispose();
            //                   }
            //                   Navigator.pop(context, true);
            //                 }
            //               } catch (e) {
            //                 //print("ddd" + e.toString());
            //                 //await controller.close();
            //                 //controller.dispose();
            //                 //print(e);
            //                 //await FlutterWebviewPlugin().close();
            //                 Navigator.pop(context, true);
            //
            //                 //print(e);
            //               }
            //
            //               //print("status dfhgvsgdv");
            //             }
            //             //myBanner?.dispose();
            //             ),
            //         actions: <Widget>[
            //             IconButton(
            //               icon: Icon(
            //                 Icons.home,
            //                 color: Colors.black,
            //               ),
            //               onPressed: () async {
            //                 //controller.close();
            //                 //controller.dispose();
            //                 //await FlutterWebviewPlugin().close();
            //                 if (!await myBanner.isLoaded()) {
            //                   //print("working");
            //                   Timer(const Duration(seconds: 2), () async {
            //                     if (!await myBanner.isLoaded()) {
            //                       Timer(const Duration(seconds: 6), () {
            //                         myBanner?.dispose();
            //                       });
            //                     } else {
            //                       myBanner?.dispose();
            //                     }
            //                   });
            //                   //print("dsd");
            //                 } else {
            //                   myBanner?.dispose();
            //                 }
            //                 Navigator.pop(context, true);
            //               },
            //             )
            //           ])
            //     : null,
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    child: InAppWebView(
                      initialUrl: widget.newspaper.url,
                      initialHeaders: {},

                      initialOptions: InAppWebViewGroupOptions(
                          crossPlatform: InAppWebViewOptions(
                              debuggingEnabled: false, supportZoom: true)),
                      onWebViewCreated: (InAppWebViewController ncontroller) {
                        controller = ncontroller;
                      },
                      // onLoadStart:
                      //     (InAppWebViewController controller, String url) {
                      //   // setState(() {
                      //   //   this.url = url;
                      //   // });
                      // },
                      // onLoadStop: (InAppWebViewController controller,
                      //     String url) async {
                      //   // setState(() {
                      //   //   this.url = url;
                      //   // });
                      // },
                      // onProgressChanged:
                      //     (InAppWebViewController controller, int progress) {
                      //   // setState(() {
                      //   //   if (progress > 80) this.showAppBar = false;
                      //   // });
                      // },
                      // onScrollChanged:
                      //     (InAppWebViewController controller, int x, int y) {
                      //   setState(() {
                      //     if (postY < y) {
                      //       _isAppbar = false;
                      //     } else {
                      //       _isAppbar = true;
                      //     }
                      //     postY = y;
                      //   });
                      // },
                      // withJavascript: true,
                      // geolocationEnabled: false,
                      // ignoreSSLErrors: true,
                      // debuggingEnabled: false,
                      // //allowFileURLs: true,
                      // appCacheEnabled: false,
                      // gestureNavigationEnabled: true,
                      // javascriptMode: JavascriptMode.unrestricted,
                      // onWebViewCreated: (WebViewController webViewController) {
                      //   _controllerCompleter.future.then((value) => _controller = value);
                      //   _controllerCompleter.complete(webViewController);
                      //
                      //   //_controller.complete(webViewController);
                      // },
                    ),
                  ),
                  Container(
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: FacebookBannerAd(
                        placementId: mainPlacementId,
                        bannerSize: BannerSize.STANDARD,
                        listener: (result, value) {
                          print("Error: $result");
                          print("Error: $value");
                          switch (result) {
                            case BannerAdResult.ERROR:
                              print("Error: $value");
                              break;
                            case BannerAdResult.LOADED:
                              print("Loaded: $value");
                              break;
                            case BannerAdResult.CLICKED:
                              print("Clicked: $value");
                              break;
                            case BannerAdResult.LOGGING_IMPRESSION:
                              print("Logging Impression: $value");
                              break;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0, 10, 40),
                    child: FloatingActionButton(
                      backgroundColor: kPrimaryColor,
                      onPressed: () async {
                        var status = await controller.canGoBack();
                        print("status" + status.toString());
                        if (status) {
                          controller.goBack();
                        } else {
                          Navigator.pop(context, true);
                        }
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      heroTag: null,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FabCircularMenu(
                      fabSize: 55,
                      alignment: Alignment.bottomRight,
                      fabColor: kPrimaryColor,
                      fabOpenIcon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      fabCloseIcon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      fabMargin: EdgeInsets.fromLTRB(0, 0, 28, 122),
                      ringDiameter: 250,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.home, color: Colors.white),
                            onPressed: () async {
                              try {
                                var status = await controller.canGoBack();
                                print("status" + status.toString());
                                if (status) {
                                  controller.goBack();
                                } else {
                                  //await controller.close();
                                  //controller.dispose();

                                  // if (!await myBanner.isLoaded()) {
                                  //   //print("test");
                                  //   Timer(const Duration(seconds: 2), () async {
                                  //     if (!await myBanner.isLoaded()) {
                                  //       Timer(const Duration(seconds: 6), () {
                                  //         myBanner?.dispose();
                                  //       });
                                  //     } else {
                                  //       myBanner?.dispose();
                                  //     }
                                  //   });
                                  //   //print("dsd");
                                  // } else {
                                  //   myBanner?.dispose();
                                  // }
                                  Navigator.pop(context, true);
                                }
                              } catch (e) {
                                //print("ddd" + e.toString());
                                //await controller.close();
                                //controller.dispose();
                                //print(e);
                                //await FlutterWebviewPlugin().close();
                                Navigator.pop(context, true);

                                //print(e);
                              }
                            }),
                        IconButton(
                            icon: Icon(Icons.zoom_out, color: Colors.white),
                            onPressed: () async {
                              await controller.zoomBy(.5);
                              print('zoom_out');
                            }),
                        IconButton(
                            icon: Icon(Icons.zoom_in, color: Colors.white),
                            onPressed: () async {
                              await controller.zoomBy(1.5);
                              print('zoom_in');
                            }),
                        IconButton(
                            icon: Icon(Icons.share, color: Colors.white),
                            onPressed: () async {
                              var url = await controller?.getUrl();
                              Share.share(url);

                              print('Favorite');
                            })
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
