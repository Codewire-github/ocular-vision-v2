import 'package:flutter/material.dart';
import 'package:ocular_vision/src/common/categories.dart';
import 'package:ocular_vision/src/widgets/discovery_card.dart';

class CategoriesCardList extends StatelessWidget {
  const CategoriesCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      children: [
        DiscoveryCard(
          index: categories[0].index,
          title: categories[0].title,
          description: categories[0].description,
          imgPath: categories[0].imgPath,
          backgroundColor: categories[0].backgroundColor,
          textColor: Colors.white,
          totalItems: 120,
          discoveredItems: 40,
        ),
        DiscoveryCard(
            index: categories[1].index,
            title: categories[1].title,
            description: categories[1].description,
            backgroundColor: categories[1].backgroundColor,
            textColor: categories[1].fontColor,
            imgPath: categories[1].imgPath,
            totalItems: 130,
            discoveredItems: 25),
        DiscoveryCard(
            index: categories[2].index,
            title: categories[2].title,
            description: categories[2].description,
            backgroundColor: categories[2].backgroundColor,
            textColor: categories[2].fontColor,
            imgPath: categories[2].imgPath,
            totalItems: 90,
            discoveredItems: 25),
        DiscoveryCard(
            index: categories[3].index,
            title: categories[3].title,
            description: categories[3].description,
            backgroundColor: categories[3].backgroundColor,
            textColor: categories[3].fontColor,
            imgPath: categories[3].imgPath,
            totalItems: 100,
            discoveredItems: 30),
        DiscoveryCard(
            index: categories[4].index,
            title: categories[4].title,
            description: categories[4].description,
            backgroundColor: categories[4].backgroundColor,
            textColor: categories[4].fontColor,
            imgPath: categories[4].imgPath,
            totalItems: 110,
            discoveredItems: 35),
      ],
    );
  }
}
