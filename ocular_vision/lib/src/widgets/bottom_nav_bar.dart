import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ocular_vision/src/common/color_constants.dart';

class CustomBottomNav extends StatelessWidget {
  final Function(int)? onTabChange;
  const CustomBottomNav({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: greyColor, borderRadius: BorderRadius.circular(40)),
      margin: EdgeInsets.fromLTRB(35, 0, 35, 20),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        tabBackgroundColor: transPrimaryColor,
        color: Colors.grey[600],
        activeColor: primaryColor,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        tabs: const [
          GButton(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            icon: Icons.home_outlined,
            text: "Home",
            gap: 8,
          ),
          GButton(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            icon: Icons.person_outline_rounded,
            text: "Profile",
            gap: 8,
          )
        ],
      ),
    );
  }
}
