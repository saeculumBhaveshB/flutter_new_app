import 'package:flutter/material.dart';
import 'package:nokasa_user/widget/green_button.dart';

class Celebration extends StatefulWidget {
  final Widget middleWidget;
  final Widget destination;
  final String buttonText;

  const Celebration({
    super.key,
    required this.buttonText,
    required this.destination,
    required this.middleWidget,
  });

  @override
  State<Celebration> createState() => _CelebrationState();
}

class _CelebrationState extends State<Celebration> {
  void next() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget.destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFEFA41F),
          image: DecorationImage(
            image: AssetImage("assets/images/celebration.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.middleWidget,
                ],
              ),
            ),
            Column(
              children: [
                Spacer(),
                GreenButton(
                  onPressed: next,
                  isActive: true,
                  text: widget.buttonText,
                  loading: false,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
