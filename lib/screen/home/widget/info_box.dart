import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoBox extends StatefulWidget {
  final String iconUrl;
  final String heading1;
  final String heading2;
  const InfoBox(
      {super.key,
      required this.iconUrl,
      required this.heading1,
      required this.heading2});

  @override
  State<InfoBox> createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 36,
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  width: double.infinity,
                  widget.iconUrl,
                )),
          ),
          Spacer(),
          Flexible(
              flex: 55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.heading1,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Recoleta',
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.heading2,
                    style: GoogleFonts.figtree(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.0,
                      color: Colors.grey,
                      letterSpacing: 0,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
