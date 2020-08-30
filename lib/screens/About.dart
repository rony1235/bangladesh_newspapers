import 'package:bangladesh_newspapers/widgets/BoxNewsPaper.dart';
import 'package:bangladesh_newspapers/widgets/MainTabBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:bangladesh_newspapers/services/DataProvider.dart';
import 'package:bangladesh_newspapers/screens/web.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => new _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  //TabController tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "About",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 40),
        ),
      ),
      backgroundColor: kPrimaryLightColor,
    );
  }
}
