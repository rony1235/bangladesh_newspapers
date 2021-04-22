import 'dart:async';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
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

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: testDevice != null ? <String>[testDevice] : null,
      keywords: <String>['game', 'newspaper'],
      //contentUrl: 'https://flutter.io',
      //birthday: DateTime.now(),
      childDirected: false,
      nonPersonalizedAds: false
      //designedForFamilies: false,
      //gender: MobileAdGender.male,
      );

  @override
  _webInappwebviewState createState() => _webInappwebviewState();
}

class _webInappwebviewState extends State<webInappwebview> {
  final _key = UniqueKey();

  bool showAppBar = true;

  InAppWebViewController controller;

  String url = "";

  double progress = 0;

  void initState() {
    //super.initState();
    //FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);

    // FirebaseAdMob.instance
    //     .initialize(appId: "ca-app-pub-4471555289018876~9616924043");

    FacebookAudienceNetwork.init(
        //testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
        );

    // RewardedVideoAd.instance.listener =
    //     (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
    //   print("RewardedVideoAd event $event");
    //   if (event == RewardedVideoAdEvent.rewarded) {
    //     print("rewardAmount" + rewardAmount.toString());
    //   }
    // };
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
          RewardedVideoAd.instance
              .load(
                  adUnitId: "ca-app-pub-4471555289018876/1165255741",
                  //RewardedVideoAd.testAdUnitId,
                  targetingInfo: webInappwebview.targetingInfo)
              .catchError((e) => print('Error in loading.'));
          ;
          prefs.setInt("paperVisit", number + 1);
        } else if (number >= ShowAdsNumber) {
          prefs.setInt("paperVisit", 0);
          try {
            await RewardedVideoAd.instance
                .show()
                .catchError((e) => print('Error in loading.'));
            ;
          } on PlatformException catch (e) {}
        } else {
          prefs.setInt("paperVisit", number + 1);
        }
      } catch (e) {}
    }
  }

  BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: //BannerAd.testAdUnitId,
        "ca-app-pub-4471555289018876/7187757128", // "ca-app-pub-2877215416565320/1305026042", //BannerAd.testAdUnitId,
    size: AdSize.banner,
    targetingInfo: webInappwebview.targetingInfo,

    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );

  Future<void> dispose() async {
    print("myBanner?.dispose()");
    //await controller..close();
    //controller.dispose();
    //super.dispose();
    myBanner?.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            if (!await myBanner.isLoaded()) {
              //print("test");
              Timer(const Duration(seconds: 2), () async {
                if (!await myBanner.isLoaded()) {
                  Timer(const Duration(seconds: 6), () {
                    myBanner?.dispose();
                  });
                } else {
                  myBanner?.dispose();
                }
              });
              //print("dsd");
            } else {
              myBanner?.dispose();
            }
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
        appBar: showAppBar
            ? AppBar(
                backgroundColor: Colors.white,
                flexibleSpace: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Hero(
                        tag: '${widget.page}imageHero${widget.newspaper.url}',
                        child: widget.newspaper.icon.contains("svg")
                            ? SvgPicture.asset(
                                "images/${widget.newspaper.icon}",
                                fit: BoxFit.contain,
                                height: 30,
                              )
                            : Image.asset(
                                "images/${widget.newspaper.icon}",
                                fit: BoxFit.contain,
                                height: 30,
                              ),
                      ),
                    ),
                  ),
                ),
                centerTitle: true,
                leading: BackButton(
                    color: Colors.black,
                    onPressed: () async {
                      // print("bef");
                      try {
                        var status = await controller.canGoBack();
                        print("status" + status.toString());
                        if (status) {
                          controller.goBack();
                        } else {
                          //await controller.close();
                          //controller.dispose();

                          if (!await myBanner.isLoaded()) {
                            //print("test");
                            Timer(const Duration(seconds: 2), () async {
                              if (!await myBanner.isLoaded()) {
                                Timer(const Duration(seconds: 6), () {
                                  myBanner?.dispose();
                                });
                              } else {
                                myBanner?.dispose();
                              }
                            });
                            //print("dsd");
                          } else {
                            myBanner?.dispose();
                          }
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

                      //print("status dfhgvsgdv");
                    }
                    //myBanner?.dispose();
                    ),
                actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        //controller.close();
                        //controller.dispose();
                        //await FlutterWebviewPlugin().close();
                        if (!await myBanner.isLoaded()) {
                          //print("working");
                          Timer(const Duration(seconds: 2), () async {
                            if (!await myBanner.isLoaded()) {
                              Timer(const Duration(seconds: 6), () {
                                myBanner?.dispose();
                              });
                            } else {
                              myBanner?.dispose();
                            }
                          });
                          //print("dsd");
                        } else {
                          myBanner?.dispose();
                        }
                        Navigator.pop(context, true);
                      },
                    )
                  ])
            : null,
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                InAppWebView(
                  initialUrl: widget.newspaper.url,
                  initialHeaders: {},

                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: true, supportZoom: true)),
                  onWebViewCreated: (InAppWebViewController ncontroller) {
                    controller = ncontroller;
                  },
                  onLoadStart: (InAppWebViewController controller, String url) {
                    // setState(() {
                    //   this.url = url;
                    // });
                  },
                  onLoadStop:
                      (InAppWebViewController controller, String url) async {
                    // setState(() {
                    //   this.url = url;
                    // });
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      if (progress > 80) this.showAppBar = false;
                    });
                  },
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
                Container(
                  alignment: Alignment.bottomCenter,
                  child: FacebookBannerAd(
                    placementId: "306255247337644_306258744003961",
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
              ],
            ),
          ),
        ),
        floatingActionButton: FabCircularMenu(
            fabSize: 35,
            alignment: Alignment.bottomRight,
            fabMargin: EdgeInsets.fromLTRB(0, 0, 10, 70),
            ringDiameter: 250,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.home),
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
                  icon: Icon(Icons.zoom_out),
                  onPressed: () async {
                    await controller.zoomBy(.5);
                    print('zoom_out');
                  }),
              IconButton(
                  icon: Icon(Icons.zoom_in),
                  onPressed: () async {
                    await controller.zoomBy(1.5);
                    print('zoom_in');
                  }),
              IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async {
                    var url = await controller?.getUrl();
                    Share.share(url);

                    print('Favorite');
                  })
            ]),
      ),
    );
  }
}
