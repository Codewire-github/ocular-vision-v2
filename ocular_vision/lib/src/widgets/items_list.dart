import 'package:flutter/material.dart';
import 'package:ocular_vision/src/widgets/item_card.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        constraints: const BoxConstraints(
          minHeight: 300,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Your discoveries:",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins"),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                ItemCard(),
                ItemCard(),
                ItemCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
