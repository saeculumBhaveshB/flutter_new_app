import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokasa_user/widget/text/heading_text.dart';

class CashbackWidget extends StatefulWidget {
  final num amount;
  const CashbackWidget({super.key, required this.amount});

  @override
  State<CashbackWidget> createState() => _CashbackWidgetState();
}

class _CashbackWidgetState extends State<CashbackWidget> {
  final TextStyle textStyle = GoogleFonts.figtree(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1.0,
    letterSpacing: 0.0,
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Yay!! You're earning",
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            HeadingText(
              text: "₹ ${widget.amount.toStringAsFixed(0)}",
              fontSize: 64,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 180,
              child: Text(
                "It should be credited into your account in the next 24 hours",
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
