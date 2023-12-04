import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ocular_vision/src/common/categories.dart';
import 'package:ocular_vision/src/widgets/circular_progress_bar.dart';
import 'package:ocular_vision/src/widgets/items_list.dart';

class CategoriesListScreen extends StatefulWidget {
  const CategoriesListScreen({super.key});

  @override
  State<CategoriesListScreen> createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  late int index = 0;
  late int discoveredItems = 0;
  late dynamic responseData;
  String title = "";
  String description = "";
  String imgPath = "";
  int totalItems = 0;
  Color backgroundColor = Colors.white;
  Color fontColor = Colors.black;

  @override
  void initState() {
    super.initState();
    try {
      Map<String, dynamic> arguments = Get.arguments;
      if (arguments != null) {
        index = arguments['index'] ?? 0;
        discoveredItems = arguments['discoveredItems'] ?? 0;
        responseData = arguments['responseData'];
      }
      loadData();
    } catch (error) {
      print('Error in initState: $error');
    }
  }

  void loadData() {
    setState(() {
      title = categories[index].title;
      description = categories[index].description;
      imgPath = categories[index].imgPath;
      totalItems = categories[index].totalItems;
      backgroundColor = categories[index].backgroundColor;
      fontColor = categories[index].fontColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    //To retrive the index from previous screen
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: fontColor,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: screenWidth,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(title,
                                      style: TextStyle(
                                        color: fontColor,
                                        fontSize: 33,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins",
                                      )),
                                  const SizedBox(height: 10),
                                  Text(description,
                                      style: TextStyle(
                                        color: fontColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                      )),
                                ],
                              ),
                            ),
                            Image.asset(
                              imgPath,
                              width: 120,
                              height: 170,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Achievement:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: fontColor,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "$discoveredItems / $totalItems",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                      const Text("  items",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            CircularProgressBar(
                                progressPercent: (discoveredItems / totalItems),
                                textColor: fontColor),
                          ],
                        )
                      ],
                    )),
                const SizedBox(height: 30),
                ItemList(responseData: responseData, category: title),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
