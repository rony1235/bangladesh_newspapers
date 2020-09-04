import 'package:bangladesh_newspapers/screens/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:bangladesh_newspapers/screens/SplashScreen.dart';

void main() => runApp(MaterialApp(
      title: 'GridView Demo',
      home: SplashScreen(),
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: MaterialColor(0xff407473, const {
            50: kPrimaryColor,
            100: kPrimaryColor,
            200: kPrimaryColor,
            300: kPrimaryColor,
            400: kPrimaryColor,
            500: kPrimaryColor,
            600: kPrimaryColor,
            700: kPrimaryColor,
            800: kPrimaryColor,
            900: kPrimaryColor
          }),
          accentColor: kPrimaryTextColor,
          primaryColor: kPrimaryColor,
          fontFamily: 'Sansnarrow'),
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        HOME_SCREEN: (BuildContext context) => Dashboard(),
        //GRID_ITEM_DETAILS_SCREEN: (BuildContext context) => GridItemDetails(),
      },
    ));
