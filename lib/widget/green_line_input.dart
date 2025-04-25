import 'package:flutter/material.dart';
import 'package:nokasa_user/utils/colors.dart';

class GreenLineInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final int maxInputSize;
  final bool obscureText;
  final String hintText;
  final String error;
  final Function()? onClick;
  final bool phoneInput;
  const GreenLineInput(
      {super.key,
      required this.controller,
      this.inputType = TextInputType.name,
      required this.maxInputSize,
      required this.error,
      this.obscureText = false,
      this.hintText = "",
      this.onClick,
      this.phoneInput = false});

  @override
  State<GreenLineInput> createState() => _GreenLineInputState();
}

class _GreenLineInputState extends State<GreenLineInput> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: primaryColor, width: 1.5),
              ),
            ),
            child: Row(
              children: [
                if (widget.phoneInput)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    child: Text(
                      "+91",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                Expanded(
                  child: TextField(
                    onTap: widget.onClick,
                    controller: widget.controller,
                    keyboardType: widget.inputType,
                    obscureText: widget.obscureText,
                    style: TextStyle(fontSize: 18),
                    maxLength: widget.maxInputSize,
                    decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
