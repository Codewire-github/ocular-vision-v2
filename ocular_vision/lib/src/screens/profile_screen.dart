import 'package:flutter/material.dart';
import 'package:ocular_vision/src/common/color_constants.dart';
import 'package:ocular_vision/src/widgets/item_card.dart';

class ProfileScreen extends StatefulWidget {

  ProfileScreen({  
    Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 60), // Added gap at the top
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage("https://via.placeholder.com/100x100"),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Patlu Prasad',
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
                                size: 30,
                              ),
                              Text(
                                'Total discoveries: 10',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 20,
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
                SizedBox(height: 20), // Add some space between the upper and lower containers
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
                      SizedBox(height: 20), // Add some space at the top
                      Text(
                        'Find your time capsules here',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5), // Add some space between text and button
                      ElevatedButton(
                        onPressed: () {
                          // Add your action here
                        },
                        child: Text('Bookmarks'),
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                          ),
                        ),
                      ),
                      SizedBox(height: 05), // Add some space between the buttons
                      ItemCard(
                        imageName: "patlu",
                        date: "07/07/2021",
                        image: "https://via.placeholder.com/100x100",
                      ),
                      SizedBox(height: 5),
                      ItemCard(
                        imageName: "patlu",
                        date: "07/07/2021",
                        image: "https://via.placeholder.com/100x100",
                      ),SizedBox(height: 5),
                      ItemCard(
                        imageName: "patlu",
                        date: "07/07/2021",
                        image: "https://via.placeholder.com/100x100",
                      ),SizedBox(height: 5),
                      ItemCard(
                        imageName: "patlu",
                        date: "07/07/2021",
                        image: "https://via.placeholder.com/100x100",
                      ),SizedBox(height: 5),
                      ItemCard(
                        imageName: "patlu",
                        date: "07/07/2021",
                        image: "https://via.placeholder.com/100x100",
                      ),SizedBox(height: 5),
                      ItemCard(
                        imageName: "patlu",
                        date: "07/07/2021",
                        image: "https://via.placeholder.com/100x100",
                      ),
                      SizedBox(height: 100), // Add some space at the bottom
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
