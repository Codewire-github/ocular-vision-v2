import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ocular_vision/src/screens/explore_screen.dart';
import 'package:ocular_vision/src/screens/profile_screen.dart';
import 'package:ocular_vision/src/widgets/bottom_nav_bar.dart';
import 'package:ocular_vision/src/screens/camera_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  dynamic responseData; // Hold the response data
  int selectedIndex = 0;
  String userEmail = "patluPrasad@yahoo.com"; // Variable accessible throughout the screen

  @override
  void initState() {
    super.initState();
    getUserData(userEmail);
  }

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> screens() => [
        ExploreScreen(responseData: responseData), 
        ProfileScreen(responseData: responseData), 
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Transform.scale(
          scale: 1.5,
          child: FloatingActionButton(
            onPressed: () {
              Get.to(CameraScreen(email: userEmail));
            },
            backgroundColor: const Color.fromARGB(255, 62, 8, 255),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: const BorderSide(
                color: Colors.black,
                width: 5.0,
              ),
            ),
            child: const Icon(Icons.document_scanner_rounded,
                size: 25, color: Colors.white),
          ),
        ),
        bottomNavigationBar: CustomBottomNav(
          onTabChange: (index) => navigateBottomBar(index),
        ),
        body: screens()[selectedIndex],
      ),
    );
  }

  Future<void> getUserData(String userEmail) async {
  final String apiUrl = "http://192.168.1.87:8080/api/ocular"; 
  final response = await http.get(Uri.parse('$apiUrl?userName=$userEmail'));

  if (response.statusCode == 200) {
    setState(() {
      // Store the pretty-printed JSON in responseData
      responseData = _prettyPrint(json.decode(response.body));
    });

    // Print the formatted JSON string
    print("User data received:\n${responseData}");
  } else {
    print("Failed to load user data. Status code: ${response.statusCode}");
  } 
}

// Function to pretty print JSON
String _prettyPrint(dynamic json) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(json);
}

}
