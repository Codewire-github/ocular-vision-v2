import 'package:flutter/material.dart';
import 'package:ocular_vision/src/common/categories.dart';
import 'package:ocular_vision/src/widgets/discovery_card.dart';
import 'dart:convert';

class CategoriesCardList extends StatelessWidget {
  final dynamic responseData;
  const CategoriesCardList({Key? key, required this.responseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("CategoriesCardList responseData: $responseData");

    List<dynamic> decodedResponseData = [];
    if (responseData != null) {
      try {
        decodedResponseData = jsonDecode(responseData);
      } catch (e) {
        print("Error decoding responseData: $e");
        // Handle the decoding error, if any
      }
    }

    if (categories != null && categories.length > 4) {
      return ListView(
        padding: const EdgeInsets.only(bottom: 50),
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics().parent,
        children: [
          DiscoveryCard(
            index: categories[4].index,
            title: categories[4].title,
            description: categories[4].description,
            backgroundColor: categories[4].backgroundColor,
            textColor: categories[4].fontColor,
            imgPath: categories[4].imgPath,
            totalItems: categories[4].totalItems,
            discoveredItems: responseData == null
                ? 0
                : getUniqueImageNamesCount(decodedResponseData, categories[4].title, categories[4].totalItems),
            responseData: responseData,
          ),
        ],
      );
    } else {
      // Handle the case where categories is null or doesn't have an element at index 4
      return Center(
        child: Text("Invalid categories data"),
      );
    }
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

