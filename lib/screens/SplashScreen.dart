import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bangladesh_newspapers/widgets/ColorLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("paperVisit", 0);
    var _duration = new Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //systemNavigationBarColor: kPrimaryColor, // navigation bar color
        // systemNavigationBarColor: Colors.blue, // navigation bar color
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    );
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 20.0, height: 100.0),
                Text(
                  'List',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(width: 20.0, height: 100.0),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Sansnarrow',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText(
                        'List',
                        textStyle: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Lato',
                        ),
                      ),
                      RotateAnimatedText('Flip'),
                      RotateAnimatedText('All'),
                    ],
                    repeatForever: true,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
      backgroundColor: Colors.redAccent,
    );
  }
}
