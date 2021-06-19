import 'dart:math';

import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemData {
  final Color color;
  final String image;
  final String text1;
  final String text2;
  final String text3;

  ItemData(this.color, this.image, this.text1, this.text2, this.text3);
}

/// Example of LiquidSwipe with itemBuilder
class WithBuilder extends StatefulWidget {
  @override
  _WithBuilder createState() => _WithBuilder();
}

class _WithBuilder extends State<WithBuilder> {
  int page = 0;
  LiquidController liquidController;
  UpdateType updateType;

  List<ItemData> data = [
    ItemData(Colors.blue, "assets/1.png", "Hi", "It's Me", "Sahdeep"),
    ItemData(Colors.deepPurpleAccent, "assets/1.png", "Take a", "Look At",
        "Liquid Swipe"),
    ItemData(Colors.green, "assets/1.png", "Liked?", "Fork!", "Give Star!"),
    ItemData(Colors.yellow, "assets/1.png", "Can be", "Used for",
        "Onboarding design"),
    ItemData(Colors.red, "assets/1.png", "Do", "try it", "Thank you"),
  ];
  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  color: data[index].color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        data[index].image,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            data[index].text1,
                            style: WithPages.style,
                          ),
                          Text(
                            data[index].text2,
                            style: WithPages.style,
                          ),
                          Text(
                            data[index].text3,
                            style: WithPages.style,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              positionSlideIcon: 0.8,
              slideIconWidget: Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(data.length, _buildDot),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: FlatButton(
                  onPressed: () {
                    liquidController.animateToPage(
                        page: data.length - 1, duration: 700);
                  },
                  child: Text("Skip to End"),
                  color: Colors.white.withOpacity(0.01),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: FlatButton(
                  onPressed: () {
                    liquidController.jumpToPage(
                        page: liquidController.currentPage + 1 > data.length - 1
                            ? 0
                            : liquidController.currentPage + 1);
                  },
                  child: Text("Next"),
                  color: Colors.white.withOpacity(0.01),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}

///Example of App with LiquidSwipe by providing list of widgets
class WithPages extends StatefulWidget {
  static final style = TextStyle(
      fontSize: 30,
      fontFamily: "Billy",
      fontWeight: FontWeight.w600,
      color: Colors.white);

  @override
  _WithPages createState() => _WithPages();
}

class _WithPages extends State<WithPages> {
  int page = 0;
  LiquidController liquidController;
  UpdateType updateType;
  double screenWidth = 0.0;

  @override
  Future<void> initState() {
    liquidController = LiquidController();
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var firstTime = prefs.setBool("firstTime", true);
  }

  final pages = [
    Container(
      color: Colors.pink,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SvgPicture.asset(
            'common_assert/home.svg',
            fit: BoxFit.contain,
          ),
          Column(
            children: <Widget>[
              Text(
                "Which Newspaper you want to read",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.deepPurpleAccent,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SvgPicture.asset(
            'common_assert/Scroll.svg',
            fit: BoxFit.contain,
          ),
          Column(
            children: <Widget>[
              Text(
                "Scroll unlimited News on Hybrid Platform",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.greenAccent,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SvgPicture.asset(
            'common_assert/flip.svg',
            fit: BoxFit.contain,
          ),
          Column(
            children: <Widget>[
              Text(
                "Flip News",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.yellowAccent,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SvgPicture.asset(
            'common_assert/Wishlist.svg',
            fit: BoxFit.contain,
          ),
          Column(
            children: <Widget>[
              Text(
                "Make Favourite",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.blueAccent,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SvgPicture.asset(
            'common_assert/Social_share.svg',
            fit: BoxFit.contain,
          ),
          Column(
            children: <Widget>[
              Text(
                "Social Share",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
  ];

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe(
              pages: [
                Container(
                  color: Colors.pink,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 500,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(120.0, 180, 120, 120),
                            child: SvgPicture.asset(
                              'common_assert/home.svg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "নিজের পছন্দমত",
                              style: WithPages.style,
                            ),
                            Text(
                              "সংবাদপত্র",
                              style: WithPages.style,
                            ),
                            Text(
                              "পাঠ করুন ",
                              style: WithPages.style,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.deepPurpleAccent,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 500,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(120.0, 180, 120, 120),
                            child: SvgPicture.asset(
                              'common_assert/Scroll.svg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "আমাদের হাইব্রিড",
                              style: WithPages.style,
                            ),
                            Text(
                              "প্ল্যাটফর্মে  ",
                              style: WithPages.style,
                            ),
                            Text(
                              "গুরুত্বপূর্ণ সংবাদ স্ক্রোল করুন",
                              style: WithPages.style,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.greenAccent,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 500,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(120.0, 180, 120, 120),
                            child: SvgPicture.asset(
                              'common_assert/flip.svg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "ফ্লিপ করুন আর",
                              style: WithPages.style,
                            ),
                            Text(
                              "সংবাদ ",
                              style: WithPages.style,
                            ),
                            Text(
                              "পড়ুন",
                              style: WithPages.style,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.blueAccent,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 500,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(120.0, 180, 120, 120),
                            child: SvgPicture.asset(
                              'common_assert/Wishlist.svg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "আপনার পছন্দের ",
                              style: WithPages.style,
                            ),
                            Text(
                              " সংবাদপত্র নিয়ে পছন্দের ",
                              style: WithPages.style,
                            ),
                            Text(
                              "তালিকা তৈরী করুন",
                              style: WithPages.style,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.greenAccent,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 500,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(120.0, 180, 120, 120),
                            child: SvgPicture.asset(
                              'common_assert/Social_share.svg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "সোশ্যাল মিডিয়াতে",
                              style: WithPages.style,
                            ),
                            Text(
                              " শেয়ার ",
                              style: WithPages.style,
                            ),
                            Text(
                              "করুন",
                              style: WithPages.style,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              positionSlideIcon: 0.8,
              slideIconWidget: Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(pages.length, _buildDot),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: page != 4
                    ? TextButton(
                        onPressed: () {
                          liquidController.animateToPage(
                              page: pages.length - 1, duration: 700);
                        },
                        child: Text("Skip to End"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19.0),
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, HOME_SCREEN);
                          // Navigator.of(context)
                          //     .pushReplacementNamed(HOME_SCREEN);
                        },
                        child: Text("Home"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19.0),
                          ),
                        ),
                      ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  child: Text("Next"),
                  onPressed: () {
                    liquidController.jumpToPage(
                        page:
                            liquidController.currentPage + 1 > pages.length - 1
                                ? 0
                                : liquidController.currentPage + 1);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}
