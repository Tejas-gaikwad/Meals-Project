import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesPrvider extends ChangeNotifier {
  List categories = [];
  getCategories() async {
    var res = await http.get(
        Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));

    print("RESPONSE FROM GET CATEGORIES " + res.body.toString());

    var rawData = await jsonDecode(res.body);

    categories = await rawData['categories'];

    notifyListeners();
  }
}
