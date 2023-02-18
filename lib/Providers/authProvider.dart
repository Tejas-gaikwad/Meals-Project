import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool auth = false;
  authentication(String emailId, String password) async {
    if (emailId == "admin" && password == "1234") {
      auth = true;

      final prefs = await SharedPreferences.getInstance();

      prefs.setBool('authenticated', true);

      notifyListeners();
    } else {
      auth = false;
      notifyListeners();
    }
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('authenticated', false);
  }
}
