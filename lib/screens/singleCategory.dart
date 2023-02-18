import 'package:appdid_task/screens/specificMeal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../Providers/categoriesProvider.dart';
import '../Providers/singleCategory.dart';

class SingleCategory extends StatefulWidget {
  final category;
  const SingleCategory({super.key, required this.category});

  @override
  State<SingleCategory> createState() => _SingleCategoryState();
}

class _SingleCategoryState extends State<SingleCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSingleCategoryDatas();
  }

  bool isLoading = false;

  Future getSingleCategoryDatas() async {
    setState(() {
      isLoading = true;
    });
    var singleCategoriesProvider =
        await Provider.of<SingleCategoryProvider>(context, listen: false);
    await singleCategoriesProvider.getSingleCategoryDetails(widget.category);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.toString()),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Consumer<SingleCategoryProvider>(
                        builder: (context, singleCategoruProvider, child) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return SpecificMealScreen(
                                          mealId: singleCategoruProvider
                                              .meals[index]['idMeal']
                                              .toString(),
                                        );
                                      },
                                    ));
                                  },
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(singleCategoruProvider
                                              .meals[index]['strMeal']
                                              .toString()),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.6,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          child: Image.network(
                                              singleCategoruProvider
                                                  .meals[index]['strMealThumb']
                                                  .toString()),
                                        ),
                                        SizedBox(height: 10),
                                        Divider(color: Colors.grey, height: 3),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
