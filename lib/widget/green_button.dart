import 'package:flutter/material.dart';
import 'package:nokasa_user/utils/colors.dart';

class GreenButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isActive;
  final String text;
  final bool loading;
  const GreenButton({
    super.key,
    required this.onPressed,
    required this.isActive,
    required this.text,
    required this.loading,
  });

  @override
  State<GreenButton> createState() => _GreenButtonState();
}

class _GreenButtonState extends State<GreenButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.isActive ? widget.onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: widget.loading
            ? CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
