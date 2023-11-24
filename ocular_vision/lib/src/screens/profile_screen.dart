import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final dynamic responseData;

  ProfileScreen({Key? key, required this.responseData}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // Log responseData to check its value
    print("ProfileScreen responseData: ${widget.responseData}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "I am profile screen",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
