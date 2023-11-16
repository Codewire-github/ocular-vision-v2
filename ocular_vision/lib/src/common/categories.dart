import 'package:flutter/material.dart';

class Categories {
  late int index;
  late String title;
  late String description;
  late String imgPath;
  late Color backgroundColor;
  late Color fontColor;
  Categories(this.index, this.title, this.description, this.imgPath,
      this.backgroundColor, this.fontColor);
}

List<Categories> categories = [
  Categories(
      0,
      'Plants',
      "Plants: the silent poets that whisper life into every corner of our world.",
      "assets/img/plant.png",
      const Color.fromARGB(255, 0, 100, 83),
      Colors.white),
  Categories(
      1,
      'Animals',
      "In the kingdom of life, animals are the poets, each heartbeat a verse in the symphony of nature.",
      'assets/img/animal.png',
      const Color.fromARGB(255, 245, 236, 216),
      Colors.black),
  Categories(
      2,
      'Foods',
      'Foods: the only art you can eat and savor with all your senses.',
      'assets/img/foods.png',
      const Color.fromARGB(255, 255, 79, 48),
      Colors.white),
  Categories(
      3,
      'Technology',
      "The seamless fusion of knowledge and innovation, shaping a future where possibilities are limitless.",
      'assets/img/laptop.png',
      const Color.fromARGB(255, 0, 227, 167),
      Colors.black),
  Categories(
      4,
      'Birds',
      "Birds: Winged wonders, painting the skies with melodies of freedom.",
      'assets/img/eagle.png',
      const Color.fromARGB(255, 135, 207, 235),
      Colors.black),
];
