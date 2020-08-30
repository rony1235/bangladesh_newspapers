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
      child: Container(
        child: Text(category.category),
      ),
    );
  }
}
