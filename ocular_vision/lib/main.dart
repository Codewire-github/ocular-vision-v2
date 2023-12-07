import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocular_vision/src/screens/auth_screen.dart';
import 'package:ocular_vision/src/screens/google_sign_in.dart';
import 'package:ocular_vision/src/screens/logged_in_widget.dart';
import 'package:ocular_vision/src/screens/root_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ocular_vision/src/screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

// The main application widget.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          ),
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //     fontFamily: Theme.of(context).platform == TargetPlatform.android
          //         ? "Poppins"
          //         : null),

          home: AuthScreen(),
        ),
      );
}
