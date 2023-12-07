import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocular_vision/src/screens/explore_screen.dart';
import 'package:ocular_vision/src/screens/info_screen.dart';
import 'package:ocular_vision/src/screens/profile_screen.dart';
import 'package:ocular_vision/src/widgets/bottom_nav_bar.dart';
import 'package:ocular_vision/src/screens/camera_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

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

  void showTextAlert(String message) {
    Get.snackbar('Alert', message, duration: const Duration(seconds: 4));
  }

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
            onPressed: () async {
              var cameraStatus = await Permission.camera.request();
              print('$cameraStatus');
              if (cameraStatus.isGranted) {
                Get.to(const CameraScreen());
              } else if (cameraStatus.isPermanentlyDenied) {
                showTextAlert(
                    'Camera permission is permanently denied. Please enable it in the device settings.');
                openAppSettings();
              } else {
                showTextAlert('Camera access denied. Failed to continue');
              }
            },
            backgroundColor: const Color.fromARGB(255, 74, 2, 255),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(50.0), // Set your desired border radius
              side: const BorderSide(
                  color: Colors.black,
                  width: 5.0), // Set your desired border color and width
            ),
            child: const Icon(Icons.document_scanner_rounded,
                size: 25, color: Colors.white),
          ),
        ),
        bottomNavigationBar:
            CustomBottomNav(onTabChange: (index) => navigateBottomBar(index)),
        body: screens[selectedIndex],
      ),
    );
  }
}
