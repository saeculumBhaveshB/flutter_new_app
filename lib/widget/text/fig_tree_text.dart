import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FigtreeText extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  const FigtreeText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.textColor = Colors.black,
      this.fontWeight = FontWeight.w600});

  @override
  State<FigtreeText> createState() => _FigtreeTextState();
}

class _FigtreeTextState extends State<FigtreeText> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        widget.text,
        style: GoogleFonts.figtree(
          color: widget.textColor,
          fontWeight: widget.fontWeight,
          fontSize: widget.fontSize,
          height: 1.0,
          letterSpacing: 0,
          textBaseline: TextBaseline.alphabetic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
