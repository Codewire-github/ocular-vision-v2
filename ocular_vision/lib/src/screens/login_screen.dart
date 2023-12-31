import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ocular_vision/src/screens/camera_screen_unauthorized.dart';
import 'package:ocular_vision/src/screens/google_sign_in.dart';
import 'package:provider/provider.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

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
  const TitleWidget({super.key});

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
  final dynamic provider;
  const LoginScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fem = screenWidth / 393;

    return Material(
      type: MaterialType.transparency,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          extendBody: false,
          body: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(
                    horizontal: 50 * fem,
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
                      SizedBox(height: 15),
                      Text(
                        'Explore the world around you',
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontSize: 19),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  width: screenWidth,
                  height: 220 * fem,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50 * fem),
                        topRight: Radius.circular(50 * fem),
                      ),
                      color: Colors.white // Set the desired color here
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to Ocular Vision",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Automatically sync your profile to the cloud.",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 2, 2, 230),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton.icon(
                            onPressed: () {
                              provider.googleLogin();
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Continue with Google",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                      const SizedBox(height: 10),
                      TextButton.icon(
                          onPressed: () {
                            Get.to(CameraScreenUnauthoried());
                          },
                          icon: const Icon(
                            Icons.center_focus_strong_rounded,
                            size: 25,
                            color: Color.fromARGB(255, 2, 2, 230),
                          ),
                          label: Text(
                            "Scan without signing in.",
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                color: Color.fromARGB(255, 2, 2, 230),
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                decorationColor:
                                    Color.fromARGB(255, 2, 2, 230)),
                          ))
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
