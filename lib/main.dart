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
            50: const Color(0xff407473),
            100: const Color(0xff407473),
            200: const Color(0xff407473),
            300: const Color(0xff407473),
            400: const Color(0xff407473),
            500: const Color(0xff407473),
            600: const Color(0xff407473),
            700: const Color(0xff407473),
            800: const Color(0xff407473),
            900: const Color(0xff407473)
          }),
          accentColor: Color(0xff407473),
          primaryColor: Color(0xff407473),
          fontFamily: 'Sansnarrow'),
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        HOME_SCREEN: (BuildContext context) => Home(),
        //GRID_ITEM_DETAILS_SCREEN: (BuildContext context) => GridItemDetails(),
      },
    ));
