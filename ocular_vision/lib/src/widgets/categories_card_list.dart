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
    List<dynamic> decodedResponseData = jsonDecode(responseData);
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
          discoveredItems: getUniqueImageNamesCount(decodedResponseData, categories[4].title, categories[4].totalItems),
          responseData: responseData, 
        )
      ],
    );
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
