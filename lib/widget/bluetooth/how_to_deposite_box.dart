import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HowToDepositeBox extends StatefulWidget {
  final String imageUrl;
  final String text;
  const HowToDepositeBox(
      {super.key, required this.imageUrl, required this.text});

  @override
  State<HowToDepositeBox> createState() => _HowToDepositeBoxState();
}

class _HowToDepositeBoxState extends State<HowToDepositeBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: Column(
        children: [
          Image.asset(
            widget.imageUrl,
            width: double.infinity,
          ),
          Text(
            widget.text,
            style: GoogleFonts.figtree(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.0,
                letterSpacing: 0.0,
                color: Color.fromRGBO(79, 79, 79, 1.0)),
          )
        ],
      ),
    );
  }
}
