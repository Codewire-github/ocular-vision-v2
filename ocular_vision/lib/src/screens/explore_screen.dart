import 'package:flutter/material.dart';
import 'package:ocular_vision/src/widgets/categories_card_list.dart';
import 'package:ocular_vision/src/screens/live_search_screen.dart';

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
            const SizedBox(height: 20),
            Expanded(child: CategoriesCardList(responseData: widget.responseData))
          ],
        ),
      ),
    );
  }
}
