import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String title1, title2, text1, text2;
  final VoidCallback onPressed;
  const DialogBox(
      {super.key,
      required this.title1,
      required this.title2,
      this.text1 = "cancel",
      this.text2 = "ok",
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title1),
      content: Text(title2),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: Text(text1),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(text2),
        ),
      ],
    );
  }
}
