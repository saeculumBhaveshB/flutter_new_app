import 'package:flutter/material.dart';
import 'package:nokasa_user/utils/colors.dart';

class PageNo extends StatefulWidget {
  final bool active;
  const PageNo({super.key, required this.active});

  @override
  State<PageNo> createState() => _PageNoState();
}

class _PageNoState extends State<PageNo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: widget.active ? primaryColor : Color.fromRGBO(0, 70, 60, 0.3),
      ),
      height: 4,
      width: double.infinity,
    );
  }
}
