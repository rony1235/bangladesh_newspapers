import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/screens/Dashboard.dart';
import 'package:bangladesh_newspapers/screens/webInappwebview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:bangladesh_newspapers/screens/SplashScreen.dart';
import 'package:flutter/services.dart';
import 'package:bangladesh_newspapers/utilities/FirstPages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "MainNavigator");
// Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a backsssground message: ${message.messageId}");
//   if (message.data != null) {
//     final data = message.data;
//
//     final url = data['url'];
//     //final body = data['message'];
//     print("Handling a backgrossgnbnbund message: ${message.messageId + url}");
//     navigatorKey.currentState.push(MaterialPageRoute(
//         builder: (context) => webInappwebview(
//             NewspaperList(name: "", icon: "", isFavorite: false, url: url),
//             null)));
//     // Get.to((webInappwebview(
//     //     NewspaperList(name: "", icon: "", isFavorite: false, url: url), null)));
//     //await _showNotificationWithDefaultSound(title, message);
//   }
//   return Future<void>.value();
// }

// Future myBackgroundMessageHandler(RemoteMessage message) async {
//   /// something to do
//
//   print("Handling a backgrossgnbnbund message: ${message.messageId}");
// }
var firstTime = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  SharedPreferences prefs = await SharedPreferences.getInstance();
  firstTime = prefs.getBool("firstTime");
  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    title: 'সংবাদপত্র',
    debugShowCheckedModeBanner: false,
    home: firstTime == null ? WithPages() : Dashboard(),
    routes: <String, WidgetBuilder>{
      SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
      HOME_SCREEN: (BuildContext context) => Dashboard(),
      TUTORIAL: (BuildContext context) => WithPages(),
      //GRID_ITEM_DETAILS_SCREEN: (BuildContext context) => GridItemDetails(),
    },
  ));
  // MaterialApp(
  //   title: 'সংবাদপত্র',
  //   home: SplashScreen(),
  //   themeMode: ThemeMode.light, // Change it as you want
  //   theme: ThemeData(
  //       fontFamily: 'Sansnarrow',
  //       primaryColor: Colors.white,
  //       primaryColorBrightness: Brightness.light,
  //       brightness: Brightness.light,
  //       primaryColorDark: Colors.black,
  //       canvasColor: Colors.white,
  //       // next line is important!
  //       appBarTheme: AppBarTheme(brightness: Brightness.light)),
  //   darkTheme: ThemeData(
  //     fontFamily: 'Sansnarrow',
  //     primaryColor: Colors.black,
  //     primaryColorBrightness: Brightness.dark,
  //     primaryColorLight: Colors.black,
  //     brightness: Brightness.dark,
  //     primaryColorDark: Colors.black,
  //     indicatorColor: Colors.white,
  //     canvasColor: Colors.black,
  //     // next line is important!
  //     appBarTheme: AppBarTheme(brightness: Brightness.dark),
  //   ),
  //   debugShowCheckedModeBanner: false,
  //   // theme: ThemeData(
  //   //     primarySwatch: MaterialColor(0xff3182ce, const {
  //   //       50: kPrimaryColor,
  //   //       100: kPrimaryColor,
  //   //       200: kPrimaryColor,
  //   //       300: kPrimaryColor,
  //   //       400: kPrimaryColor,
  //   //       500: kPrimaryColor,
  //   //       600: kPrimaryColor,
  //   //       700: kPrimaryColor,
  //   //       800: kPrimaryColor,
  //   //       900: kPrimaryColor
  //   //     }),
  //   //     accentColor: kPrimaryTextColor,
  //   //     primaryColor: kPrimaryColor,
  //   //     fontFamily: 'Lato'),
  //   routes: <String, WidgetBuilder>{
  //     SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
  //     HOME_SCREEN: (BuildContext context) => Dashboard(),
  //     //GRID_ITEM_DETAILS_SCREEN: (BuildContext context) => GridItemDetails(),
  //   },
  //),
  //);
}
