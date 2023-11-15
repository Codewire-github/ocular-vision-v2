import 'package:flutter/material.dart';
import 'package:ocular_vision/src/widgets/discovery_card.dart';

class Categories {
  late String title;
  late String description;
  late String imgPath;
  late Color backgroundColor;
  late Color fontColor;
  Categories(this.title, this.description, this.imgPath, this.backgroundColor,
      this.fontColor);
}

class EdibleCards extends StatelessWidget {
  const EdibleCards({super.key});

  @override
  Widget build(BuildContext context) {
    List<Categories> categories = [
      Categories(
          'Plants',
          "Plants: the silent poets that whisper life into every corner of our world.",
          "assets/img/plant.png",
          const Color.fromARGB(255, 0, 100, 83),
          Colors.white),
      Categories(
          'Food',
          'Food: the only art you can eat and savor with all your senses.',
          'assets/img/food.webp',
          const Color.fromARGB(255, 255, 79, 48),
          Colors.white),
      Categories(
          'Birds',
          "Birds: Winged wonders, painting the skies with melodies of freedom.",
          'assets/img/eagle.png',
          const Color.fromARGB(255, 135, 207, 235),
          Colors.black),
    ];
    return ListView(
      padding: const EdgeInsets.all(0),
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      children: [
        DiscoveryCard(
          title: categories[0].title,
          description: categories[0].description,
          imgPath: categories[0].imgPath,
          backgroundColor: categories[0].backgroundColor,
          textColor: Colors.white,
          totalItems: 120,
          discoveredItems: 40,
        ),
        DiscoveryCard(
            title: categories[1].title,
            description: categories[1].description,
            backgroundColor: categories[1].backgroundColor,
            textColor: categories[1].fontColor,
            imgPath: categories[1].imgPath,
            totalItems: 130,
            discoveredItems: 25),
        DiscoveryCard(
            title: categories[2].title,
            description: categories[2].description,
            backgroundColor: categories[2].backgroundColor,
            textColor: categories[2].fontColor,
            imgPath: categories[2].imgPath,
            totalItems: 90,
            discoveredItems: 25),
      ],
    );
  }
}
