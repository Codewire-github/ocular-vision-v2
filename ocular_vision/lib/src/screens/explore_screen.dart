import 'package:flutter/material.dart';
import 'package:ocular_vision/src/widgets/categories_card_list.dart';

class ExploreScreen extends StatefulWidget {
  final dynamic responseData;

  ExploreScreen({Key? key, required this.responseData}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    print("ExploreScreen responseData: ${widget.responseData}");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Explore the world around you.",
              style: TextStyle(
                fontSize: 38,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 12.5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_rounded,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Search the objects you have discovered",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.explore_rounded,
                  size: 30,
                ),
                SizedBox(width: 5),
                Text(
                  "Discover",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: CategoriesCardList(responseData: widget.responseData))
          ],
        ),
      ),
    );
  }
}
