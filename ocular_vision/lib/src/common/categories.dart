import 'package:flutter/material.dart';

class Categories {
  late int index;
  late String title;
  late String description;
  late String imgPath;
  late Color backgroundColor;
  late Color fontColor;
  late int totalItems;

  Categories(
      this.index, this.title, this.description, this.imgPath,
      this.backgroundColor, this.fontColor, this.totalItems);
}

List<Categories> categories = [
  Categories(
    0,
    'Plants',
    "Plants: the silent poets that whisper life into every corner of our world.",
    "assets/img/plant.png",
    Color.fromARGB(255, 0, 100, 83),
    Colors.white,
    4,
  ),
  Categories(
    1,
    'Animals',
    "In the kingdom of life, animals are the poets, each heartbeat a verse in the symphony of nature.",
    'assets/img/animal.png',
    Color.fromARGB(255, 245, 236, 216),
    Colors.black,
    4,
  ),
  Categories(
    2,
    'Foods',
    'Foods: the only art you can eat and savor with all your senses.',
    'assets/img/foods.png',
    Color.fromARGB(255, 255, 79, 48),
    Colors.white,
    4,
  ),
  Categories(
    3,
    'Technology',
    "The seamless fusion of knowledge and innovation, shaping a future where possibilities are limitless.",
    'assets/img/laptop.png',
    Color.fromARGB(255, 0, 227, 167),
    Colors.black,
    4,
  ),
  Categories(
    4,
    'Furniture',
    'Furniture: Fusion of form and function, weaving comfort and style into the fabric of your home.',
    'assets/img/sofa.png',
    Color.fromARGB(255, 210, 180, 140),
    Colors.black,
    4,
  ),
  Categories(
    5,
    'Flowers',
    'Flowers: Nature way of expressing joy, each petal a brushstroke in the masterpiece of life.',
    'assets/img/flower.png',
    Color.fromARGB(255, 230, 230, 250),
    Colors.black,
    4,
  ),
  Categories(
    6,
    'Birds',
    "Birds: Winged wonders, painting the skies with melodies of freedom.",
    'assets/img/eagle.png',
    Color.fromARGB(255, 135, 207, 235),
    Colors.black,
    4,
  ),
];
