import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ocular_vision/src/screens/explore_screen.dart';
import 'package:ocular_vision/src/screens/auth_screen.dart';
import 'package:ocular_vision/src/widgets/bottom_nav_bar.dart';
import 'package:ocular_vision/src/screens/camera_screen.dart';
import 'package:ocular_vision/src/screens/profile_screen.dart';

class RootScreen extends StatefulWidget {


  const RootScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  dynamic responseData; // Hold the response data
  int selectedIndex = 0;
  String userEmail =
      "patluPrasad@yahoo.com"; // Variable accessible throughout the screen

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
        ExploreScreen(
          responseData: responseData,
        ),
        AuthScreen(),
        ProfileScreen(
        ),  
      ];

  Widget build(BuildContext context) {
  if (responseData == null) {
    // Display an error message or perform any other actions for error handling
  return GetMaterialApp(
  debugShowCheckedModeBanner: false,
  home: Center(
    child: Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Failed connecting to server.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black, // Set the text color to black
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getUserData(userEmail);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[700], // Set the button background color to white
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Retry',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    color: Colors.white, // Set the button text color to black
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);


  } 
  else {
    // Display the widget tree when there is no error
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
