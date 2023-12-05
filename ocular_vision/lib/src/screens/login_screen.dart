import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn;

  GoogleSignInService(this._googleSignIn);

  Future<void> handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      print("Google Sign-In Result: $account");
    } catch (error) {
      print("Error during Google Sign-In: $error");
    }
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 393;
    return Container(
      width: 209 * fem,
      height: 105 * fem,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://i.ibb.co/m07h2pC/logo1-2.png"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 393;
    return Text(
      'OCULAR VISION',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 36 * fem,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600,
        letterSpacing: 2.0,
      ),
    );
  }
}

class ContinueWithWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 393;
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * fem),
      child: Text(
        'Continue with: ',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF3C3737),
          fontSize: 20 * fem,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

class GoogleSignInWidget extends StatelessWidget {
  final GoogleSignIn _googleSignIn; // Adjusted the type

  GoogleSignInWidget(this._googleSignIn);

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 393;
    return GestureDetector(
      onTap: () async {
        try {
          GoogleSignInAccount? account = await _googleSignIn.signIn();
          print("Google Sign-In Result: $account");
        } catch (error) {
          print("Error during Google Sign-In: $error");
        }
      },
      //signIn box
      child: Container(
        width: 290 * fem,
        height: 64 * fem,
        child: Stack(
          children: [
            //box
            Positioned(
              left: 4 * fem,
              top: 0,
              child: Container(
                width: 286 * fem,
                height: 64 * fem,
                decoration: ShapeDecoration(
                  color: Color(0xFF2A2A2A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24 * fem),
                  ),
                ),
              ),
            ),
            //google text
            Positioned(
              child: SizedBox(
                width: 240 * fem,
                height: 160 * fem,
                child: Center(
                  child: Text(
                    'Google ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFF6E0),
                      fontSize: 28 * fem,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            //google logo
            Positioned(
              left: 177 * fem,
              top: 4 * fem,
              child: Container(
                width: 55 * fem,
                height: 55 * fem,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://i.ibb.co/mbV4LmB/image-1.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class LoginScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn;

  LoginScreen(this._googleSignIn);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fem = screenWidth / 393;

    return Material(
      type: MaterialType.transparency,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          extendBody: false,
          body: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(
                    horizontal: 72 * fem,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Color(0xFF171717)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LogoWidget(),
                      const SizedBox(height: 31),
                      TitleWidget(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: screenWidth,
                  height: 180 * fem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80 * fem),
                      topRight: Radius.circular(80 * fem),
                    ),
                    color: Color(0xFFB4A8FF), // Set the desired color here
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ContinueWithWidget(),
                      GoogleSignInWidget(_googleSignIn),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
