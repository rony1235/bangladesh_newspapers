import 'dart:async';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String testDevice = 'F6836817538F494C0544BC912D578A82';
const int ShowAdsNumber = 3;

// ignore: must_be_immutable
class MyWebTestView extends StatelessWidget {
  final NewspaperList newspaper;

  WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  MyWebTestView(this.newspaper) {
    //print("http://foo.com/bar.html");
    showAds();
  }
  @override
  void initState() {
    //super.initState();
    //FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-2877215416565320~1401213050");

    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        print("rewardAmount" + rewardAmount.toString());
      }
    };
  }

  Future<void> showAds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var number = prefs.getInt("paperVisit");
    if (number == null) {
      prefs.setInt("paperVisit", 0);
    } else {
      // print("paperVisit" + number.toString());
      if (number == ShowAdsNumber - 1) {
        RewardedVideoAd.instance.load(
            adUnitId: RewardedVideoAd.testAdUnitId,
            targetingInfo: targetingInfo);
        prefs.setInt("paperVisit", number + 1);
      } else if (number >= ShowAdsNumber) {
        prefs.setInt("paperVisit", 0);
        RewardedVideoAd.instance.show();
      } else {
        prefs.setInt("paperVisit", number + 1);
      }
    }
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: testDevice != null ? <String>[testDevice] : null,
      keywords: <String>['game', 'newspaper'],
      contentUrl: 'https://flutter.io',
      //birthday: DateTime.now(),
      childDirected: false,
      nonPersonalizedAds: false
      //designedForFamilies: false,
      //gender: MobileAdGender.male,
      );
  BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: BannerAd
        .testAdUnitId, // "ca-app-pub-2877215416565320/1305026042", //BannerAd.testAdUnitId,
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,

    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );
  @override
  void dispose() {
    print("myBanner?.dispose()");
    myBanner?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //controllerGlobal = _controller;
    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 10.0,
        // Positions the banner ad 10 pixels from the center of the screen to the right
        horizontalCenterOffset: 10.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
    return WillPopScope(
      onWillPop: () async {
        print("bef");
        var status = await _controller.canGoBack();
        print(status);
        if (status) {
          _controller.goBack();
          return false;
        } else {
          if (!await myBanner.isLoaded()) {
            print("working");
            Timer(const Duration(seconds: 2), () async {
              if (!await myBanner.isLoaded()) {
                Timer(const Duration(seconds: 6), () {
                  myBanner?.dispose();
                });
              } else {
                myBanner?.dispose();
              }
            });
            print("dsd");
          } else {
            myBanner?.dispose();
          }

          return true;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            flexibleSpace: SafeArea(
              child: Hero(
                tag: 'imageHero${newspaper.url}',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: newspaper.icon.contains("svg")
                          ? SvgPicture.asset(
                              "images/${newspaper.icon}",
                            )
                          : Image.asset(
                              "images/${newspaper.icon}",
                            )),
                ),
              ),
            ),
            centerTitle: true,
            leading: BackButton(
                color: Colors.black,
                onPressed: () async {
                  print("bef");
                  var status = await _controller.canGoBack();
                  print(status);
                  if (status) {
                    _controller.goBack();
                  } else {
                    if (!await myBanner.isLoaded()) {
                      print("working");
                      Timer(const Duration(seconds: 2), () async {
                        if (!await myBanner.isLoaded()) {
                          Timer(const Duration(seconds: 6), () {
                            myBanner?.dispose();
                          });
                        } else {
                          myBanner?.dispose();
                        }
                      });
                      print("dsd");
                    } else {
                      myBanner?.dispose();
                    }

                    Navigator.pop(context, true);
                  }
                  //myBanner?.dispose();
                }),
          ),
          body: WebView(
            initialUrl: newspaper.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controllerCompleter.future.then((value) => _controller = value);
              _controllerCompleter.complete(webViewController);
              //_controller.complete(webViewController);
            },
          )),
    );
  }
}
