import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomMealProvider extends ChangeNotifier {
  List randomMeal = [];
  getRandomMEal() async {
    var res = await http
        .get(Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php"));

    print(jsonDecode(res.body));

    var rawData = jsonDecode(res.body)['meals'];

    randomMeal = rawData;

    notifyListeners();
  }
}
