import 'package:appdid_task/Providers/categoriesProvider.dart';
import 'package:appdid_task/screens/searchScreen.dart';
import 'package:appdid_task/screens/singleCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import 'drawerUI.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategories();
  }

  bool isLoading = false;

  getAllCategories() async {
    setState(() {
      isLoading = true;
    });

    var categoriesProvider =
        await Provider.of<CategoriesPrvider>(context, listen: false);
    await categoriesProvider.getCategories();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerUI(),
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return SearchScreen();
              },
            ));
          },
          child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 08),
              color: Colors.grey.withOpacity(0.0),
              child: const Text("Search")),
        ),
        actions: [
          InkWell(
            onTap: () async {
              var categoriesProvider =
                  await Provider.of<CategoriesPrvider>(context, listen: false);
              categoriesProvider.getCategories();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 06),
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<CategoriesPrvider>(
          builder: (BuildContext context, providerModel, Widget? child) {
            return isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: providerModel.categories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return SingleCategory(
                                  category: providerModel.categories[index]
                                          ['strCategory']
                                      .toString(),
                                );
                              },
                            ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 08),
                                Text(providerModel.categories[index]
                                            ['idCategory']
                                        .toString() +
                                    ") " +
                                    providerModel.categories[index]
                                            ['strCategory']
                                        .toString()),
                                const SizedBox(height: 08),
                                Image.network(providerModel.categories[index]
                                        ['strCategoryThumb']
                                    .toString()),
                                const SizedBox(height: 08),
                                Text(
                                  providerModel.categories[index]
                                          ['strCategoryDescription']
                                      .toString(),
                                  maxLines: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
