import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => new _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  //TabController tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.settings,
          size: 80,
        ),
      ),
      backgroundColor: kPrimaryColor,
    );
  }
}
