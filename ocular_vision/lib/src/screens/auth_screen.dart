// auth_screen.dart
import 'package:flutter/material.dart';
import 'package:ocular_vision/src/screens/login_screen.dart';
import 'package:ocular_vision/src/screens/root_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('AuthScreen');

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              return RootScreen(
                userName: user.displayName ?? '', // Handle null displayName
                userImage: user.photoURL ?? '', // Handle null photoURL
                email: user.email ?? '', // Handle null email
              );
            } else {
              return Center(child: Text('User data unavailable'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Something Went Wrong!'));
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
