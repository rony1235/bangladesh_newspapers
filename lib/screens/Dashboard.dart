import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/screens/FavoriteScreen.dart';
import 'package:bangladesh_newspapers/screens/SettingScreen.dart';
import 'package:bangladesh_newspapers/screens/webInappwebview.dart';
import 'package:bangladesh_newspapers/utilities/DataSearch.dart';
import 'package:bangladesh_newspapers/utilities/FirstPages.dart';
import 'package:bangladesh_newspapers/widgets/NavButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:ff_navigation_bar/ff_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:bangladesh_newspapers/screens/SettingScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import 'About.dart';
import 'HomeScreen.dart';
import 'SearchScreen.dart';
import 'FlipMain.dart';

Future _showNotificationWithDefaultSound(String t, String b, int id) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max, priority: Priority.max);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    id,
    t,
    b,
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  print(message.data.hashCode);
  print(message.data['title']);
  print(message.data['body']);
  print(channel.id);
  print(channel.name);
  print(channel.description);

  flutterLocalNotificationsPlugin.show(
      10,
      "dfsdsdf",
      "dfsdsrdfsdfsdf",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
    enableLights: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Dashboard extends StatefulWidget {
  static final String id = 'profile_page';
  final int tab;

  const Dashboard({
    this.tab = 0, // nullable and optional
  });
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PageController _pageController;

  // ignore: non_constant_identifier_names
  //int _Page = 0;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    // var initializationSettingsAndroid = AndroidInitializationSettings(
    //     '@mipmap/ic_launcher'); // <- default icon name is
    // //var initiializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // var initializationSettings =
    //     InitializationSettings(android: initializationSettingsAndroid);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: $message");
      if (message.data != null) {
        final data = message.data;

        final url = data['url'];
        //final body = data['message'];
        print(
            "Handling a backgrossgnbnbund message: ${message.messageId + url}");
        navigatorKey.currentState.push(MaterialPageRoute(
            builder: (context) => webInappwebview(
                NewspaperList(name: "", icon: "", isFavorite: false, url: url),
                null)));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");

      if (message.data != null) {
        final data = message.data;

        final url = data['url'];
        //final body = data['message'];
        print(
            "Handling a backgrossgnbnbund message: ${message.messageId + url}");
        navigatorKey.currentState.push(MaterialPageRoute(
            builder: (context) => webInappwebview(
                NewspaperList(name: "", icon: "", isFavorite: false, url: url),
                null)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 35,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: Colors.black54,
                    size: 30.0,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer());
            },
          ),
          title: Image.asset(
            "common_assert/logo.png",
            height: 38,
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                onPressed: () async {
                  showSearch(context: context, delegate: DataSearch(context));
                })
          ],
          centerTitle: true,
          elevation: 0,
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: SafeArea(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,

              children: <Widget>[
                // DrawerHeader(
                //     decoration: BoxDecoration(
                //       color: Color(0xff151419),
                //     ),
                //     child: Image.asset(
                //       kMainImageLocation + "roar.png",
                //     )),

                ListTile(
                    focusColor: Colors.redAccent,
                    title: Image.asset(
                      "common_assert/logo.png",
                    )),

                ListTile(
                  focusColor: Colors.redAccent,
                  title: Text(
                    'Home',
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(
                    Icons.home,
                    size: 26,
                  ),
                  onTap: () {
                    _pageController.jumpToPage(0);
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  focusColor: Colors.redAccent,
                  title: Text(
                    'Search',
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(
                    Icons.search,
                    size: 26,
                  ),
                  onTap: () {
                    _pageController.jumpToPage(1);
                    // Update the state of the app.
                    // ...

                    //Scaffold.of(context).openEndDrawer();
                  },
                ),
                ListTile(
                  title: Text(
                    'Tour',
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(
                    Icons.touch_app,
                    size: 26,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, TUTORIAL);
                    // Navigator.of(context)
                    //     .pushReplacementNamed(TUTORIAL);
                    // ...
                  },
                ),
                ListTile(
                  title: Text(
                    'Setting',
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(
                    Icons.settings,
                    size: 26,
                  ),
                  onTap: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) =>
                    //             SettingScreen()));

                    //Page1
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingScreen()))
                        .then((value) {
                      print("dsdd");
                      //setState(() {});
                      Navigator.pop(context); // pop current page
                      Navigator.pushNamed(context, HOME_SCREEN); // push
                      //_pageController.jumpToPage(1);
                      //_pageController.jumpToPage(2);
                    });
                    //Navigator.of(context).pushReplacementNamed(TUTORIAL);
                    // Navigator.of(context).push(
                    //   PageRouteBuilder(
                    //     transitionDuration: Duration(milliseconds: 0),
                    //     pageBuilder: (BuildContext context,
                    //         Animation<double> animation,
                    //         Animation<double> secondaryAnimation) {
                    //       return SettingScreen();
                    //     },
                    //     transitionsBuilder: (BuildContext context,
                    //         Animation<double> animation,
                    //         Animation<double> secondaryAnimation,
                    //         Widget child) {
                    //       return Align(
                    //         child: FadeTransition(
                    //           opacity: animation,
                    //           child: child,
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // );
                    // Navigator.of(context)
                    //     .pushReplacementNamed(TUTORIAL);
                    // ...
                  },
                ),
              ],
            ),
          ),
        ),
        // appBar: AppBar(
        //   backgroundColor: kPrimaryDarkColor,
        //   shadowColor: kPrimaryColor,
        //   title: Padding(
        //     padding: const EdgeInsets.all(2.0),
        //     child: Text(
        //       "All Bangla Newspaper",
        //       style: TextStyle(
        //           fontWeight: FontWeight.w800,
        //           fontSize: 22,
        //           color: kPrimaryTextColor),
        //     ),
        //   ),
        //   centerTitle: true,
        // ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 20,
                child: PageView(
                    controller: _pageController,
                    children: <Widget>[
                      HomeScreen(
                        tab: widget.tab,
                      ),
                      SearchScreen(),
                      FavoriteScreen(),
                      FlipMainScreen(),
                      AboutScreen(),
                    ],
                    onPageChanged: (int index) {
                      setState(() {
                        _pageController.jumpToPage(index);
                        _page = index;

                        // final CurvedNavigationBarState navBarState =
                        //     _bottomNavigationKey.currentState;
                        // navBarState.setPage(index);
                      });
                    }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black45,
          // unselectedLabelStyle: TextStyle(
          //   color: Colors.black45,
          // ),
          onTap: (newIndex) => setState(() => setState(() {
                //selectedIndex = index;
                _page = newIndex;
                _pageController.jumpToPage(newIndex);
              })),
          currentIndex: _page,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Category"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite"),
            BottomNavigationBarItem(icon: Icon(Icons.flip), label: "Flip"),
            BottomNavigationBarItem(
                icon: Icon(Icons.line_style), label: "News"),
          ],
        ),
        // bottomNavigationBar: FFNavigationBar(
        //   theme: FFNavigationBarTheme(
        //     barBackgroundColor: Colors.white,
        //     selectedItemBorderColor: Colors.black,
        //     selectedItemBackgroundColor: Colors.black45,
        //     selectedItemIconColor: Colors.white,
        //     selectedItemLabelColor: Colors.black,
        //   ),
        //   selectedIndex: _page,
        //   onSelectTab: (index) {
        //     setState(() {
        //       //selectedIndex = index;
        //       _page = index;
        //       _pageController.jumpToPage(index);
        //     });
        //   },
        //   items: [
        //     FFNavigationBarItem(
        //       iconData: Icons.home,
        //       label: 'Home',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.search,
        //       label: 'Search',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.favorite,
        //       label: 'Favorite',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.flip,
        //       label: 'Flip',
        //     ),
        //     FFNavigationBarItem(
        //       iconData: Icons.line_style,
        //       label: 'Settings',
        //     ),
        //   ],
        // ),
        // bottomNavigationBar: CurvedNavigationBar(
        //   //animationCurve: Curves.easeInOutBack,
        //   key: _bottomNavigationKey,
        //   index: 0,
        //   items: <Widget>[
        //     Icon(Icons.home, size: 30),
        //     Icon(Icons.search, size: 30),
        //     Icon(Icons.favorite, size: 30),
        //     Icon(Icons.flip, size: 30),
        //     Icon(Icons.line_style, size: 30),
        //   ],
        //   // items: <Widget>[
        //   //   NavButton(_page, Icons.home, 0, "Home"),
        //   //   NavButton(_page, Icons.search, 1, "Search"),
        //   //   NavButton(_page, Icons.favorite, 2, "Favorite"),
        //   //   NavButton(_page, Icons.flip, 3, "flip"),
        //   //   NavButton(_page, Icons.line_style, 4, "Info"),
        //   // ],
        //   color: Colors.white,
        //   buttonBackgroundColor: kPrimaryColor,
        //   backgroundColor: Colors.white,
        //   animationCurve: Curves.easeInOut,
        //   animationDuration: Duration(milliseconds: 600),
        //   height: 50.0,
        //   letIndexChange: (index) => true,
        //   onTap: (int index) {
        //     setState(() {
        //       //_Page = index;
        //       _page = index;
        //       _pageController.jumpToPage(index);
        //     });
        //   },
        // ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
