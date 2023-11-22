import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> screens = const [
    ExploreScreen(),
    ProfileScreen(),
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
              Get.to(CameraScreen(email: "patluPrasad@yahoo.com"));
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
        body: screens[selectedIndex],
      ),
    );
  }
}
