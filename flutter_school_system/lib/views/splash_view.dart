import 'package:flutter/material.dart';

import '../constants/check_role.dart';
import '../constants/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final CheckRole _checkRole = CheckRole();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      _checkRole.checkUser(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -100,
              left: -110,
              child: Container(
                width: width * 0.7,
                height: height * 0.2,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0XFF28C2A0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: height * 0.13),
              child: Center(child: Image.asset(logo)),
            ),
            Positioned(
              bottom: -320,
              child: Container(
                width: width,
                height: height * 0.6,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0XFF0C46C4)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: const Text(
                  "Version: 1",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
