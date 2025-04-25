import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/error_screen.dart';

class NoEnoughBags extends StatelessWidget {
  const NoEnoughBags({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorScreen(
        imageUrl: "assets/images/no_enough_bags.png",
        headingtext: "Sorry!",
        secondaryText: "Not enough bags");
  }
}