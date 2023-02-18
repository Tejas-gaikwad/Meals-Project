import 'dart:developer';

import 'package:appdid_task/Providers/authProvider.dart';
import 'package:appdid_task/Providers/categoriesProvider.dart';
import 'package:appdid_task/screens/auth/loginScreen.dart';
import 'package:appdid_task/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Providers/getSpecificMeal.dart';
import 'Providers/randomMealProvider.dart';
import 'Providers/searchProvider.dart';
import 'Providers/singleCategory.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserStatus();
  }

  String userStatus = "false";

  getUserStatus() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userStatus = prefs.getBool('authenticated').toString();
    });

    log(userStatus.toString());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoriesPrvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SingleCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SingleMealProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RandomMealProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: userStatus == "true" ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}


// authentication
// logout
// search
// refresh
// share function
// 
// 