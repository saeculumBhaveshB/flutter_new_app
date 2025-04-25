import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/error_screen.dart';

class BluethoothNotConnected extends StatelessWidget {
  const BluethoothNotConnected({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorScreen(
        imageUrl: "assets/images/not_connected.png",
        headingtext: "Sorry!",
        secondaryText: "Unable to find your bin");
  }
}
