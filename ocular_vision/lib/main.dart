import 'package:flutter/material.dart';
import 'package:ocular_vision/src/screens/root_screen.dart';

void main() {
  runApp(const App());
}

// The main application widget.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootScreen(),
    );
  }
}
