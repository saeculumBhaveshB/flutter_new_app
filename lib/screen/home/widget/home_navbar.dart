import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokasa_user/screen/profile/profile.dart';

class HomeNavbar extends StatefulWidget {
  final String name;
  const HomeNavbar({super.key, required this.name});

  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 6, right: 6),
      child: Row(
        children: [
          Text("👋 ", style: TextStyle(fontSize: 24)),
          SizedBox(
            width: 6,
          ),
          Text(
            "Hey ${widget.name}, welcome back",
            style:
                GoogleFonts.figtree(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            },
            child: Icon(
              Icons.person,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
