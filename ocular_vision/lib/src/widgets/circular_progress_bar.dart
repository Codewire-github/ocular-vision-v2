import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularProgressBar extends StatelessWidget {
  final double progressPercent;
  final Color textColor;
  const CircularProgressBar(
      {super.key, required this.progressPercent, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 30,
      lineWidth: 8,
      percent: progressPercent,
      progressColor: const Color.fromARGB(255, 231, 231, 231),
      center: Text(
        "${(progressPercent * 100).toStringAsFixed(0)}%",
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w800, color: textColor),
      ),
      backgroundColor: const Color.fromARGB(255, 33, 33, 33),
    );
  }
}
