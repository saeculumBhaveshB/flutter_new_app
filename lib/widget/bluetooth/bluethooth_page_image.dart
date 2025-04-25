import 'package:flutter/material.dart';

class BluethoothPageImage extends StatefulWidget {
  final String imageUrl;
  const BluethoothPageImage({super.key, required this.imageUrl});

  @override
  State<BluethoothPageImage> createState() => _BluethoothPageImageState();
}

class _BluethoothPageImageState extends State<BluethoothPageImage> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.imageUrl,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
