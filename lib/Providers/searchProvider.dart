import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchProvider extends ChangeNotifier {
  List searchedMeal = [];
  getSearchMeal(String mealName) async {
    var res = await http.get(Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/search.php?s=${mealName.toString()}"));

    print(jsonDecode(res.body));

    var rawData = jsonDecode(res.body)['meals'];

    searchedMeal = rawData;

    notifyListeners();
  }
}
