import 'package:flutter/material.dart';
import 'package:ocular_vision/src/common/categories.dart';
import 'package:ocular_vision/src/widgets/discovery_card.dart';
import 'dart:convert';

class CategoriesCardList extends StatefulWidget {
  final dynamic responseData;

  const CategoriesCardList({Key? key, required this.responseData}) : super(key: key);

  @override
  _CategoriesCardListState createState() => _CategoriesCardListState();
}

class _CategoriesCardListState extends State<CategoriesCardList> {
  late List<Categories> filteredCategories;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    filteredCategories = categories;
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print("CategoriesCardList responseData: ${widget.responseData}");

    List<dynamic> decodedResponseData = [];
    if (widget.responseData != null) {
      try {
        decodedResponseData = jsonDecode(widget.responseData);
      } catch (e) {
        print("Error decoding responseData: $e");
        // Handle the decoding error, if any
      }
    }

    return SingleChildScrollView(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12.5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 32,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchInputChanged(value);
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Search the objects you have discovered",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.explore_rounded,
                size: 30,
              ),
              SizedBox(width: 5),
              Text(
                "Discover",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          if (filteredCategories.isNotEmpty)
            Column(
              children: filteredCategories.map((category) {
                return 
                DiscoveryCard(
                  index: category.index,
                  title: category.title,
                  description: category.description,
                  backgroundColor: category.backgroundColor,
                  textColor: category.fontColor,
                  imgPath: category.imgPath,
                  totalItems: category.totalItems,
                  discoveredItems: widget.responseData == null
                      ? 0
                      : getUniqueImageNamesCount(
                          decodedResponseData, category.title, category.totalItems),
                  responseData: widget.responseData,
                );
              }).toList(),
            )
          else
            Center(
            child: Text(
              "No matching categories found",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Poppins",
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  void searchInputChanged(String value) {
    filteredCategories = categories
        .where((category) => category.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  int getUniqueImageNamesCount(dynamic responseData, String categoryTitle, int totalItems) {
    if (responseData is! List) {
      print('Invalid responseData type: ${responseData.runtimeType}');
      return 0;
    }

    Set<String> uniqueImageNames = {};
    int count = 0;

    for (var entry in responseData) {
      if (entry is Map && entry['imageData'] is Iterable) {
        for (var imageData in entry['imageData']) {
          if (imageData is Map &&
              imageData['category'] == categoryTitle &&
              uniqueImageNames.add(imageData['imageName'])) {
            count++;

            if (count >= totalItems) {
              return count;
            }
          }
        }
      }
    }

    print('Count: $count');
    return count;
  }
}
