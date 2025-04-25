import 'package:flutter/material.dart';
import 'package:nokasa_user/utils/colors.dart';

class HeadingText extends StatefulWidget {
  final String text;
  final double fontSize;
  const HeadingText({super.key, required this.text, this.fontSize = 36});

  @override
  State<HeadingText> createState() => _HeadingTextState();
}

class _HeadingTextState extends State<HeadingText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Recoleta',
        fontSize: widget.fontSize,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
    );
  }
}
