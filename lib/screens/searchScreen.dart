import 'package:appdid_task/screens/specificMeal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../Providers/searchProvider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAllMeals();
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.searchedMeal.clear();
  }

  getAllMeals() async {}

  List searchResult = [];

  searchMeal(String mealName) async {
    searchResult.clear();
    if (mealName.isEmpty) {
      setState(() {});
      return;
    }

    // _userDetails.forEach((userDetail) {
    //   if (userDetail.firstName.contains(mealName) ||
    //       userDetail.lastName.contains(mealName)) searchResult.add(userDetail);
    // });

    var searchProvider = Provider.of<SearchProvider>(context, listen: false);

    searchProvider.getSearchMeal(mealName.toString());

    setState(() {});
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.symmetric(vertical: 04),
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await searchMeal(searchController.text);
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.search)),
          ),
        ],
      ),
      body: SafeArea(child: Consumer<SearchProvider>(
        builder: (context, searchProviderModel, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: searchProviderModel.searchedMeal.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SpecificMealScreen(
                            mealId: searchProviderModel.searchedMeal[index]
                                    ['idMeal']
                                .toString());
                      },
                    ));
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.free_breakfast),
                        SizedBox(width: 10),
                        Text(searchProviderModel.searchedMeal[index]['strMeal']
                            .toString()),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      )),
    );
  }
}
