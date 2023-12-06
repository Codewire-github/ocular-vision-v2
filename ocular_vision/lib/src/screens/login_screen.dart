import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:ocular_vision/src/screens/google_sign_in.dart';
import 'package:provider/provider.dart';

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

class LoginScreen extends StatelessWidget {
  LoginScreen();

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
                      Text('Hello'),
                      TitleWidget(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  width: screenWidth,
                  height: 180 * fem,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60 * fem),
                        topRight: Radius.circular(60 * fem),
                      ),
                      color: Color.fromARGB(
                          255, 135, 115, 144) // Set the desired color here
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton.icon(
                            onPressed: () {
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.googleLogin();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.black,
                            ),
                            label: Text(
                              "Continue with Google",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            )),
                      )
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
