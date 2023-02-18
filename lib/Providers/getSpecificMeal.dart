// https://www.themealdb.com/api/json/v1/1/lookup.php?i=52819

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SingleMealProvider extends ChangeNotifier {
  List mealDetails = [];

  getSingleMealDetails(String mealId) async {
    var res = await http.get(Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/lookup.php?i=${mealId.toString()}"));

    print("RESPONSE FROM GET SINGLE MEAL DATA " + res.body.toString());

    var rawData = await jsonDecode(res.body);

    mealDetails = await rawData['meals'];

    notifyListeners();
  }
}
