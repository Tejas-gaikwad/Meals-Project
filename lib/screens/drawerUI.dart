import 'package:appdid_task/Providers/authProvider.dart';
import 'package:appdid_task/screens/auth/loginScreen.dart';
import 'package:appdid_task/screens/randomMeal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class DrawerUI extends StatelessWidget {
  const DrawerUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: null,
          ),
          ListTile(
            title: const Text('Random Meal'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RandomMealScreen();
                  },
                ),
              );
            },
          ),
          InkWell(
            onTap: () async {
              var authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              await authProvider.logout();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ), (route) => false);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              color: Colors.blue,
              child: Text(
                "LOGOUT",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
