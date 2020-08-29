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
    //prefs.setString(, json.encode());
    var favorite = prefs.get("Favorite");

    return myModels;
  }
}
