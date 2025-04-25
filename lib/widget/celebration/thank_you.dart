import 'package:flutter/material.dart';
import 'package:nokasa_user/widget/text/heading_text.dart';

class Thanks extends StatelessWidget {
  const Thanks({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        children: [
          HeadingText(text: "Thank you!"),
          SizedBox(
            height: 10,
          ),
          Image.asset("assets/images/celebaration_icon.png"),
        ],
      ),
    );
  }
}
