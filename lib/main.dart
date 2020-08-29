import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';

import 'package:bangladesh_newspapers/screens/GridItemDetails.dart';
import 'package:bangladesh_newspapers/screens/HomeScreen.dart';
import 'package:bangladesh_newspapers/screens/SplashScreen.dart';
import 'package:bangladesh_newspapers/screens/test.dart';

void main() => runApp(MaterialApp(
      title: 'GridView Demo',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: MaterialColor(0xff407473, const {
            50: kMainColor,
            100: kMainColor,
            200: kMainColor,
            300: kMainColor,
            400: kMainColor,
            500: kMainColor,
            600: kMainColor,
            700: kMainColor,
            800: kMainColor,
            900: kMainColor
          }),
          accentColor: kMainColor,
          primaryColor: kMainColor,
          fontFamily: 'Sansnarrow'),
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        HOME_SCREEN: (BuildContext context) => Home(),
        //GRID_ITEM_DETAILS_SCREEN: (BuildContext context) => GridItemDetails(),
      },
    ));
