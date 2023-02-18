import 'package:appdid_task/Providers/authProvider.dart';
import 'package:appdid_task/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AuthProvider>(
            builder: (context, authProviderModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("LOGIN")),
                  TextFieldConstant(
                    hintText: "UserName",
                    controller: emailController,
                  ),
                  TextFieldConstant(
                    hintText: "Password",
                    controller: passwordController,
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        await authProviderModel.authentication(
                            emailController.text, passwordController.text);

                        await authProviderModel.auth == true
                            ? Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const HomeScreen();
                                  },
                                ),
                                (route) => false,
                              )
                            : ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Authentication Failed")));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        color: Colors.blue,
                        child: Text("Login"),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class TextFieldConstant extends StatelessWidget {
  final hintText;
  final controller;
  const TextFieldConstant({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 02, vertical: 08),
      color: Colors.grey.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 08, vertical: 04),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 12)),
      ),
    );
  }
}
