import 'package:appdid_task/Providers/randomMealProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class RandomMealScreen extends StatefulWidget {
  const RandomMealScreen({super.key});

  @override
  State<RandomMealScreen> createState() => _RandomMealScreenState();
}

class _RandomMealScreenState extends State<RandomMealScreen> {
  @override
  void initState() {
    super.initState();
    getRandomMeal();
  }

  bool isLoading = false;

  Future getRandomMeal() async {
    setState(() {
      isLoading = true;
    });
    var randomProvider =
        Provider.of<RandomMealProvider>(context, listen: false);

    randomProvider.getRandomMEal();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Meal"),
      ),
      body: SafeArea(
        child: Consumer<RandomMealProvider>(
          builder: (context, randomMealProvierModel, child) {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: isLoading == true ||
                        randomMealProvierModel.randomMeal.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            InkWell(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.blue,
                                        ),
                                      );
                                    },
                                  );
                                  await randomMealProvierModel.getRandomMEal();

                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 12),
                                  color: Colors.blue,
                                  child: Text(
                                    "Get Random Meal",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(randomMealProvierModel
                                        .randomMeal[0]['strMeal']
                                        .toString()),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Text(randomMealProvierModel
                                        .randomMeal[0]['strCategory']
                                        .toString()),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(height: 10),
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.5,
                                    width: MediaQuery.of(context).size.height /
                                        1.5,
                                    child: Image.network(randomMealProvierModel
                                        .randomMeal[0]['strMealThumb']
                                        .toString()),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Text(randomMealProvierModel
                                        .randomMeal[0]['strArea']
                                        .toString()),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Text(randomMealProvierModel
                                        .randomMeal[0]['strInstructions']
                                        .toString()),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
          },
        ),
      ),
    );
  }
}
