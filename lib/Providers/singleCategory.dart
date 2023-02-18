import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SingleCategoryProvider extends ChangeNotifier {
  List meals = [];

  getSingleCategoryDetails(String category) async {
    var res = await http.get(Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=${category.toString()}"));

    print("RESPONSE FROM GET SINGLE CATEGORIES " + res.body.toString());

    var rawData = await jsonDecode(res.body);

    meals = await rawData['meals'];

    notifyListeners();
  }
}
