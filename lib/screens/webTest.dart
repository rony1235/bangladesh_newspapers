// import 'dart:async';
// import 'package:bangladesh_newspapers/utilities/constant.dart';
// import 'package:firebase_admob/firebase_admob.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//
// import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// const String testDevice = 'F6836817538F494C0544BC912D578A82';
// const int ShowAdsNumber = 5;
//
// // ignore: must_be_immutable
// class MyWebTestView extends StatelessWidget {
//   final NewspaperList newspaper;
//   final String page;
//   final _key = UniqueKey();
//   //WebViewController _controller;
//
//   //final FlutterWebviewPlugin _controller = FlutterWebviewPlugin();
//   final flutterWebviewPlugin = FlutterWebviewPlugin();
//
//   MyWebTestView(this.newspaper, this.page) {
//     //print("http://foo.com/bar.html");
//     showAds();
//   }
//
//   Future<void> initState() async {
//     //super.initState();
//     //FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
//
//     FirebaseAdMob.instance
//         .initialize(appId: "ca-app-pub-4471555289018876~9616924043");
//
//     RewardedVideoAd.instance.listener =
//         (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
//       print("RewardedVideoAd event $event");
//       if (event == RewardedVideoAdEvent.rewarded) {
//         print("rewardAmount" + rewardAmount.toString());
//       }
//     };
//   }
//
//   Future<void> showAds() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var number = prefs.getInt("paperVisit");
//     if (number == null) {
//       prefs.setInt("paperVisit", 0);
//     } else {
//       // print("paperVisit" + number.toString());
//       try {
//         if (number == ShowAdsNumber - 1) {
//           RewardedVideoAd.instance
//               .load(
//                   adUnitId: "ca-app-pub-4471555289018876/1165255741",
//                   //RewardedVideoAd.testAdUnitId,
//                   targetingInfo: targetingInfo)
//               .catchError((e) => print('Error in loading.'));
//           ;
//           prefs.setInt("paperVisit", number + 1);
//         } else if (number >= ShowAdsNumber) {
//           prefs.setInt("paperVisit", 0);
//           try {
//             await RewardedVideoAd.instance
//                 .show()
//                 .catchError((e) => print('Error in loading.'));
//             ;
//           } on PlatformException catch (e) {}
//         } else {
//           prefs.setInt("paperVisit", number + 1);
//         }
//       } catch (e) {}
//     }
//   }
//
//   static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//       testDevices: testDevice != null ? <String>[testDevice] : null,
//       keywords: <String>['game', 'newspaper'],
//       //contentUrl: 'https://flutter.io',
//       //birthday: DateTime.now(),
//       childDirected: false,
//       nonPersonalizedAds: false
//       //designedForFamilies: false,
//       //gender: MobileAdGender.male,
//       );
//   BannerAd myBanner = BannerAd(
//     // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//     // https://developers.google.com/admob/android/test-ads
//     // https://developers.google.com/admob/ios/test-ads
//     adUnitId: //BannerAd.testAdUnitId,
//         "ca-app-pub-4471555289018876/7187757128", // "ca-app-pub-2877215416565320/1305026042", //BannerAd.testAdUnitId,
//     size: AdSize.banner,
//     targetingInfo: targetingInfo,
//
//     listener: (MobileAdEvent event) {
//       print("BannerAd event is $event");
//     },
//   );
//
//   Future<void> dispose() async {
//     print("myBanner?.dispose()");
//     await flutterWebviewPlugin.close();
//     flutterWebviewPlugin.dispose();
//     //super.dispose();
//     myBanner?.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //controllerGlobal = _controller;
//     myBanner
//       // typically this happens well before the ad is shown
//       ..load()
//       ..show(
//         // Positions the banner ad 60 pixels from the bottom of the screen
//         anchorOffset: 10.0,
//         // Positions the banner ad 10 pixels from the center of the screen to the right
//         horizontalCenterOffset: 10.0,
//         // Banner Position
//         anchorType: AnchorType.bottom,
//       );
//     return WillPopScope(
//       onWillPop: () async {
//         //print("bef");
//         try {
//           var status = await flutterWebviewPlugin.canGoBack();
//           //print("status" + status.toString());
//           if (status) {
//             flutterWebviewPlugin.goBack();
//             return false;
//           } else {
//             //flutterWebviewPlugin.close();
//             await flutterWebviewPlugin.close();
//             flutterWebviewPlugin.dispose();
//             await FlutterWebviewPlugin().close();
//             if (!await myBanner.isLoaded()) {
//               //print("test");
//               Timer(const Duration(seconds: 2), () async {
//                 if (!await myBanner.isLoaded()) {
//                   Timer(const Duration(seconds: 6), () {
//                     myBanner?.dispose();
//                   });
//                 } else {
//                   myBanner?.dispose();
//                 }
//               });
//               //print("dsd");
//             } else {
//               myBanner?.dispose();
//             }
//           }
//           return true;
//         } catch (e) {
//           //print("ddd" + e.toString());
//           await flutterWebviewPlugin.close();
//           flutterWebviewPlugin.dispose();
//           //print(e);
//           return true;
//
//           //print(e);
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//             backgroundColor: Colors.white,
//             flexibleSpace: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   child: Hero(
//                       tag: '${page}imageHero${newspaper.url}',
//                       child: newspaper.icon.contains("svg")
//                           ? SvgPicture.asset(
//                               kMainImageLocation + newspaper.icon,
//                               fit: BoxFit.contain,
//                               height: 30,
//                             )
//                           : Image.asset(
//                               kMainImageLocation + newspaper.icon,
//                               fit: BoxFit.contain,
//                               height: 30,
//                             )),
//                 ),
//               ),
//             ),
//             centerTitle: true,
//             leading: BackButton(
//                 color: Colors.black,
//                 onPressed: () async {
//                   // print("bef");
//                   try {
//                     var status = await flutterWebviewPlugin.canGoBack();
//                     //print("status" + status.toString());
//                     if (status) {
//                       flutterWebviewPlugin.goBack();
//                     } else {
//                       await flutterWebviewPlugin.close();
//                       flutterWebviewPlugin.dispose();
//
//                       if (!await myBanner.isLoaded()) {
//                         //print("test");
//                         Timer(const Duration(seconds: 2), () async {
//                           if (!await myBanner.isLoaded()) {
//                             Timer(const Duration(seconds: 6), () {
//                               myBanner?.dispose();
//                             });
//                           } else {
//                             myBanner?.dispose();
//                           }
//                         });
//                         //print("dsd");
//                       } else {
//                         myBanner?.dispose();
//                       }
//                     }
//                     Navigator.pop(context, true);
//                   } catch (e) {
//                     //print("ddd" + e.toString());
//                     await flutterWebviewPlugin.close();
//                     flutterWebviewPlugin.dispose();
//                     //print(e);
//                     await FlutterWebviewPlugin().close();
//                     Navigator.pop(context, true);
//
//                     //print(e);
//                   }
//
//                   //print("status dfhgvsgdv");
//                 }
//                 //myBanner?.dispose();
//                 ),
//             actions: <Widget>[
//               IconButton(
//                 icon: Icon(
//                   Icons.home,
//                   color: Colors.black,
//                 ),
//                 onPressed: () async {
//                   await flutterWebviewPlugin.close();
//                   flutterWebviewPlugin.dispose();
//                   //await FlutterWebviewPlugin().close();
//                   if (!await myBanner.isLoaded()) {
//                     //print("working");
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
//                 },
//               )
//             ]),
//         body: Container(
//           child: WebviewScaffold(
//               url: newspaper.url,
//               displayZoomControls: true,
//               withZoom: true,
//               key: _key,
//               withLocalStorage: true,
//               hidden: true,
//               initialChild: Container(
//                 color: Colors.black,
//                 child: const Center(
//                   child: Text(''),
//                 ),
//               )
//               // withJavascript: true,
//               // geolocationEnabled: false,
//               // ignoreSSLErrors: true,
//               // debuggingEnabled: false,
//               // //allowFileURLs: true,
//               // appCacheEnabled: false,
//               // gestureNavigationEnabled: true,
//               // javascriptMode: JavascriptMode.unrestricted,
//               // onWebViewCreated: (WebViewController webViewController) {
//               //   _controllerCompleter.future.then((value) => _controller = value);
//               //   _controllerCompleter.complete(webViewController);
//               //
//               //   //_controller.complete(webViewController);
//               // },
//               ),
//         ),
//       ),
//     );
//   }
// }
