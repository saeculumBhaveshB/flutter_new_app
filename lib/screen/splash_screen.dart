import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nokasa_user/screen/front_screen.dart';
import 'package:nokasa_user/screen/home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _logoSize = 100;

  @override
  void initState() {
    super.initState();
    // AuthMethods().signOut();
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _logoSize = 200;
        });
      }
    });

    Timer(const Duration(seconds: 4), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FrontScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          width: _logoSize,
          height: _logoSize,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
