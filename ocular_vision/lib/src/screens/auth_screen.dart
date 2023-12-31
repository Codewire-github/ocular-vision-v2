// auth_screen.dart
import 'package:flutter/material.dart';
import 'package:ocular_vision/src/screens/google_sign_in.dart';
import 'package:ocular_vision/src/screens/login_screen.dart';
import 'package:ocular_vision/src/screens/root_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<_AuthScreenState> authScreenKey =
      GlobalKey<_AuthScreenState>();

  void _onAuthStateChanged() {
    authScreenKey.currentState?.setState(() {});
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((_) {
      print('Auth State Changed');
      _onAuthStateChanged();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: Consumer<GoogleSignInProvider>(
          builder: (context, provider, child) {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print('Auth State Changed: ${snapshot.connectionState}');

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  final user = FirebaseAuth.instance.currentUser;

                  return RootScreen(
                    userName:
                        user?.displayName ?? '', // Handle null displayName
                    userImage: user?.photoURL ?? '', // Handle null photoURL
                    email: user?.email ?? '', // Handle null email
                    provider: provider,
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something Went Wrong!'));
                } else {
                  return LoginScreen(
                    provider: provider,
                  );
                }
              },
            );
          },
        ),
      ));
}
