import 'package:bangladesh_newspapers/widgets/BoxNewsPaper.dart';
import 'package:bangladesh_newspapers/widgets/MainTabBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:bangladesh_newspapers/screens/web.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      backgroundColor: kPrimaryLightColor,
    );
  }
}
