import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider {
  Future<List<DataCategoryModel>> getAll() async {
    final response = await rootBundle.loadString("assets/data.json");

    List<DataCategoryModel> myModels;
    myModels = (json.decode(response) as List)
        .map((i) => DataCategoryModel.fromJson(i))
        .toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var favoriteList = prefs.getStringList("Favorite");
    // favorite.forEach((element) {
    //   print("test ---" + element);
    // });
    if (favoriteList == null) {
      favoriteList = List();
    }
    myModels.forEach((data) {
      data.newspaperList.forEach((element) {
        if (favoriteList.contains(element.url)) {
          element.isFavorite = true;
        } else {
          element.isFavorite = false;
        }
      });
    });

    return myModels;
  }
}
