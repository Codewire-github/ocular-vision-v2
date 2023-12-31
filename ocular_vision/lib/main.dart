import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocular_vision/src/screens/auth_screen.dart';
import 'package:ocular_vision/src/screens/google_sign_in.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

// The main application widget.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //     fontFamily: Theme.of(context).platform == TargetPlatform.android
      //         ? "Poppins"
      //         : null),

      home: AuthScreen(),
    );
  }
}
