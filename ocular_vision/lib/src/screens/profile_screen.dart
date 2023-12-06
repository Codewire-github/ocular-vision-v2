import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocular_vision/src/common/color_constants.dart';
import 'package:ocular_vision/src/screens/auth_screen.dart';
import 'package:ocular_vision/src/screens/google_sign_in.dart';
import 'package:ocular_vision/src/widgets/item_card.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final dynamic responseData;
  final String userName;
  final String userImage;

  ProfileScreen({
    Key? key,
    required this.responseData,
    required this.userName,
    required this.userImage,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> savedImages = [];
  int totalDiscoveries = 0;

  @override
  void initState() {
    super.initState();
    try {
      // Decode the responseData
      List<dynamic> decodedResponseData =
          widget.responseData != null ? jsonDecode(widget.responseData) : [];

      if (decodedResponseData is List) {
        for (var entry in decodedResponseData) {
          if (entry is Map &&
              entry['imageData'] is List &&
              entry['imageData'].isNotEmpty) {
            // Ensure that entry['imageData'] is List<Map<String, dynamic>>
            List<Map<String, dynamic>> categoryItems =
                List<Map<String, dynamic>>.from(entry['imageData'])
                    .where((item) => item['saved'] == true)
                    .toList();

            // Sort in descending order
            categoryItems.sort((a, b) => b['date'].compareTo(a['date']));
            savedImages.addAll(categoryItems);
          }
          totalDiscoveries = countTotalObjects(decodedResponseData);
        }
      }
    } catch (error) {
      print('Error decoding responseData: $error');
    }
  }

  int countTotalObjects(List<dynamic> responseData) {
    int totalCount = 0;

    for (var entry in responseData) {
      if (entry is Map &&
          entry['imageData'] is List &&
          entry['imageData'].isNotEmpty) {
        totalCount += (entry['imageData'] as List).length;
      }
    }

    return totalCount;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: screenWidth,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, right: 20),
                    child: TextButton(
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.logout();

                        // Get.offAll(() => {AuthScreen()});
                      },
                      child: Text('Logout'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(widget.userImage),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.userName,
                            style: TextStyle(
                              color: Color(0xFF171717),
                              fontSize: 42,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.black.withOpacity(0.8),
                                size: 20,
                              ),
                              Text(
                                'Total discoveries: $totalDiscoveries',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(56),
                      topRight: Radius.circular(56),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Find your time capsules here',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          // Add your action here
                        },
                        child: Text('Bookmarks'),
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          // Display the recent 5 items or a message if no items are available
                          if (savedImages.isNotEmpty)
                            for (var item in savedImages)
                              ItemCard(
                                imageName: item['imageName'],
                                date: item['date'],
                                image: item['image'],
                              )
                          else
                            const Text(
                              "Try discovering new items and check back here.",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Poppins",
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
