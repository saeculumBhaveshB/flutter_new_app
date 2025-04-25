import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nokasa_user/utils/colors.dart';
import 'package:nokasa_user/widget/green_button.dart';
import 'package:nokasa_user/widget/green_line_input.dart';

class UpiInput extends StatefulWidget {
  final TextEditingController otpController;
  final Future<void> Function() next;
  final bool loading;
  final String error;
  const UpiInput(
      {super.key,
      required this.otpController,
      required this.next,
      required this.loading,
      required this.error});

  @override
  State<UpiInput> createState() => _UpiInputState();
}

class _UpiInputState extends State<UpiInput> {
  bool active = false;
  @override
  void initState() {
    super.initState();
    widget.otpController.addListener(_checkInput);
  }

  @override
  void dispose() {
    widget.otpController.removeListener(_checkInput);
    super.dispose();
  }

  void _checkInput() {
    setState(() {
      active = widget.otpController.text.length >= 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            GreenLineInput(
              controller: widget.otpController,
              maxInputSize: 30,
              inputType: TextInputType.text,
              hintText: "Enter UPI id",
              error: widget.error,
            ),
          ],
        ),
        SizedBox(height: 2),
        TextButton(
          onPressed: widget.next,
          child: Text(
            "Example: username@bank",
            style: TextStyle(
              fontSize: 16,
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              shadows: [Shadow(color: grey2, offset: Offset(0, -5))],
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: GreenButton(
              onPressed: widget.next,
              isActive: active,
              text: 'Next →',
              loading: widget.loading),
        ),
      ],
    );
  }
}
