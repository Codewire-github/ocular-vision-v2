import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocular_vision/src/screens/categories_list_screen.dart';
import 'package:ocular_vision/src/widgets/circular_progress_bar.dart';

class DiscoveryCard extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final Color textColor;
  final String imgPath;
  final int totalItems;
  final int discoveredItems;
  final int index;
  final dynamic responseData;

  const DiscoveryCard(
      {super.key,
      required this.title,
      required this.description,
      required this.backgroundColor,
      required this.textColor,
      required this.imgPath,
      required this.totalItems,
      required this.discoveredItems,
      required this.index,
      required this.responseData
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          const CategoriesListScreen(),
          arguments: {'index': index, 'discoveredItems': discoveredItems, 'responseData': responseData},
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!, // Light shadow color
              offset: Offset(3, 3), // Shadow position (horizontal, vertical)
              blurRadius: 5, // Spread of the shadow
              spreadRadius: 2, // Expands the shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 22.5,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: textColor),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 200,
                      child: Text(description,
                          style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              color: textColor)),
                    ),
                  ],
                ),
                Image.asset(
                  imgPath,
                  width: 110,
                  height: 110,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Achievement:",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Poppins",
                          color: textColor),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "$discoveredItems / $totalItems",
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                color: Colors.white),
                          ),
                          const Text("  items",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Poppins",
                                  fontSize: 17,
                                  color: Colors.white))
                        ],
                      ),
                    )
                  ],
                ),
                CircularProgressBar(
                  progressPercent: (discoveredItems / totalItems),
                  textColor: textColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
