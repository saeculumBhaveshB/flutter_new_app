import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokasa_user/utils/colors.dart';

class HomeButton extends StatefulWidget {
  final Widget destination;
  final String buttonText;
  final Color buttonColor;
  const HomeButton(
      {super.key,
      required this.destination,
      required this.buttonText,
      this.buttonColor = primaryColor});

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  void next() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget.destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: next,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Text(
            widget.buttonText,
            style: GoogleFonts.figtree(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          )),
    );
  }
}
