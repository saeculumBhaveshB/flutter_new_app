import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/home/home.dart';
import 'package:nokasa_user/widget/celebration/celebration.dart';
import 'package:nokasa_user/widget/celebration/thank_you.dart';

class ThankYou extends StatefulWidget {
  const ThankYou({super.key});

  @override
  State<ThankYou> createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return Celebration(
        buttonText: "← Back to dashboard",
        destination: Home(),
        middleWidget: Thanks());
  }
}
