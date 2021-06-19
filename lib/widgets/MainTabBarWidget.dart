import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';

class MainTabBarWidget extends StatelessWidget {
  final DataCategoryModel category;
  MainTabBarWidget(
    this.category,
  );

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        category.category,
      ),
    );
  }
}
