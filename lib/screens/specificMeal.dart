import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';

import '../Providers/getSpecificMeal.dart';

class SpecificMealScreen extends StatefulWidget {
  final mealId;
  const SpecificMealScreen({super.key, required this.mealId});

  @override
  State<SpecificMealScreen> createState() => _SpecificMealScreenState();
}

class _SpecificMealScreenState extends State<SpecificMealScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    getSingleMealData();
  }

  bool isLoading = false;

  Future getSingleMealData() async {
    setState(() {
      isLoading = true;
    });
    var singleMealProvider =
        await Provider.of<SingleMealProvider>(context, listen: false);
    await singleMealProvider.getSingleMealDetails(widget.mealId.toString());
    setState(() {
      isLoading = false;
    });
  }

  shareFunc(
    String title,
    String url,
  ) async {
    await FlutterShare.share(
      title: title.toString(),
      linkUrl: url.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mealId.toString()),
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Consumer<SingleMealProvider>(
                        builder: (context, singleMealProviderModel, child) {
                          return Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  singleMealProviderModel.mealDetails.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(singleMealProviderModel
                                              .mealDetails[index]['strMeal']
                                              .toString()),
                                          InkWell(
                                              onTap: () async {
                                                await shareFunc(
                                                    singleMealProviderModel
                                                        .mealDetails[index]
                                                            ['strMeal']
                                                        .toString(),
                                                    singleMealProviderModel
                                                        .mealDetails[index]
                                                            ['strYoutube']
                                                        .toString());
                                              },
                                              child: Container(
                                                  child: Icon(Icons.share))),
                                        ],
                                      ),
                                      Text(singleMealProviderModel
                                          .mealDetails[index]['strCategory']
                                          .toString()),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        child: Image.network(
                                            singleMealProviderModel
                                                .mealDetails[index]
                                                    ['strMealThumb']
                                                .toString()),
                                      ),
                                      Text(singleMealProviderModel
                                          .mealDetails[index]['strArea']
                                          .toString()),
                                      Text(
                                        singleMealProviderModel
                                            .mealDetails[index]
                                                ['strInstructions']
                                            .toString(),
                                        maxLines: 10,
                                      ),
                                      Text(singleMealProviderModel
                                          .mealDetails[index]['strTags']
                                          .toString()),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
