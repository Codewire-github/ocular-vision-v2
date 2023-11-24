import 'package:flutter/material.dart';
import 'package:ocular_vision/src/widgets/item_card.dart';
import 'dart:convert';

class ItemList extends StatelessWidget {
  final dynamic responseData;
  final String category;

  const ItemList({
    Key? key,
    required this.responseData,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ItemList responseData: $responseData");

    List<Map<String, dynamic>> items = [];

    try {
      // Decode the responseData
      List<dynamic> decodedResponseData = jsonDecode(responseData);

      if (decodedResponseData is List) {
        for (var entry in decodedResponseData) {
          if (entry is Map &&
              entry['imageData'] is List &&
              entry['imageData'].isNotEmpty) {

            // Ensure that entry['imageData'] is List<Map<String, dynamic>>
            List<Map<String, dynamic>> categoryItems =
                List<Map<String, dynamic>>.from(entry['imageData'])
                    .where((item) => item['category'] == category)
                    .toList();
            
            //sort in ascendinf order
            categoryItems.sort((a, b) => b['date'].compareTo(a['date']));
            items.addAll(categoryItems.take(5));
          }
        }
      }
    } catch (error) {
      print('Error decoding responseData: $error');
    }

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
                fontFamily: "Poppins",
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                // Display the recent 5 items
                for (var item in items)
                  ItemCard(
                    imageName: item['imageName'],
                    date: item['date'],
                    image: item['image'],
                  ),
              ],
              )
          ],
        ),
      ),
    );
  }
}