import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokasa_user/utils/colors.dart';

class ProfileTextInput extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final bool enabled;
  final String error;
  final String prefixText;
  final String hintText;
  final TextInputType textInputType;
  final int maxSize;
  const ProfileTextInput(
      {super.key,
      required this.labelText,
      required this.textEditingController,
      required this.error,
      required this.prefixText,
      required this.hintText,
      this.textInputType = TextInputType.text,
      this.enabled = true,
      this.maxSize=20});

  @override
  State<ProfileTextInput> createState() => _ProfileTextInputState();
}

class _ProfileTextInputState extends State<ProfileTextInput> {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = GoogleFonts.figtree(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        height: 1.0,
        letterSpacing: 0);
    final TextStyle errorStyle = GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      letterSpacing: 0,
      color: Color.fromRGBO(94, 99, 104, 1),
    );
    final TextStyle hintStyle = GoogleFonts.figtree(
        fontWeight: FontWeight.w400,
        fontSize: 20,
        height: 1.0,
        letterSpacing: -0.12,
        color: Color(0xFF6D6D6D),
        decorationColor: primaryColor);
    return TextField(
        controller: widget.textEditingController,
        enabled: widget.enabled,
        style: textStyle,
        keyboardType: widget.textInputType,
        maxLength: widget.maxSize,
        decoration: InputDecoration(
          counterText: "",
          hintText: widget.hintText,
          hintStyle: hintStyle,
          prefixText: widget.prefixText,
          prefixStyle: textStyle,
          errorText: widget.error.isEmpty ? null : widget.error,
          errorStyle: errorStyle,
          labelText: widget.labelText,
        
          border: OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        ));
  }
}
