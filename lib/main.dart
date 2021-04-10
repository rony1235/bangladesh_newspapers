import 'package:bangladesh_newspapers/screens/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:bangladesh_newspapers/screens/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'সংবাদপত্র',
      home: SplashScreen(),
      themeMode: ThemeMode.light, // Change it as you want
      theme: ThemeData(
          primaryColor: Colors.white,
          primaryColorBrightness: Brightness.light,
          brightness: Brightness.light,
          primaryColorDark: Colors.black,
          canvasColor: Colors.white,
          // next line is important!
          appBarTheme: AppBarTheme(brightness: Brightness.light)),
      darkTheme: ThemeData(
        primaryColor: Colors.black,
        primaryColorBrightness: Brightness.dark,
        primaryColorLight: Colors.black,
        brightness: Brightness.dark,
        primaryColorDark: Colors.black,
        indicatorColor: Colors.white,
        canvasColor: Colors.black,
        // next line is important!
        appBarTheme: AppBarTheme(brightness: Brightness.dark),
      ),
      //debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //     primarySwatch: MaterialColor(0xff3182ce, const {
      //       50: kPrimaryColor,
      //       100: kPrimaryColor,
      //       200: kPrimaryColor,
      //       300: kPrimaryColor,
      //       400: kPrimaryColor,
      //       500: kPrimaryColor,
      //       600: kPrimaryColor,
      //       700: kPrimaryColor,
      //       800: kPrimaryColor,
      //       900: kPrimaryColor
      //     }),
      //     accentColor: kPrimaryTextColor,
      //     primaryColor: kPrimaryColor,
      //     fontFamily: 'Lato'),
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        HOME_SCREEN: (BuildContext context) => Dashboard(),
        //GRID_ITEM_DETAILS_SCREEN: (BuildContext context) => GridItemDetails(),
      },
    ),
  );
}
