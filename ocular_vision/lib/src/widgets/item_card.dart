import 'dart:math';

import 'package:flutter/material.dart';

Color generateRandomLightColor() {
  Random random = Random();

  // Generate random values for red, green, and blue
  int red = random.nextInt(56) + 160; // Values between 100 and 255
  int green = random.nextInt(56) + 160;
  int blue = random.nextInt(56) + 160;

  return Color.fromARGB(255, red, green, blue);
}

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    final lightBackgroundColor = generateRandomLightColor();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: lightBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!, // Light shadow color
            offset: Offset(4, 4), // Shadow position (horizontal, vertical)
            blurRadius: 8, // Spread of the shadow
            spreadRadius: 2, // Expands the shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://www.plantshop.me/media/product/Philodendron_Atom_-_plantshopme.jpg",
              fit: BoxFit.cover,
              width: 75,
              height: 75,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Philodendenron Atom",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Icon(
                    Icons.history_rounded,
                    color: Colors.grey[800],
                    size: 20,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "15 Nov, 2023",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800]),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
