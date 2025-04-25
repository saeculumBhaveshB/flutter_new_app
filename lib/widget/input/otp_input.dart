import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nokasa_user/utils/colors.dart';
import 'package:nokasa_user/widget/green_button.dart';
import 'package:nokasa_user/widget/green_line_input.dart';
import 'package:smart_auth/smart_auth.dart';

class OtpInput extends StatefulWidget {
  final TextEditingController otpController;
  final Future<void> Function() next;
  final bool loading;
  final bool firstTimeUser;
  final String error;
  const OtpInput(
      {super.key,
      required this.otpController,
      required this.next,
      required this.loading,
      required this.firstTimeUser,
      required this.error});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  bool active = false;
  int _secondsRemaining = 60;
  bool _isButtonEnabled = false;
  Timer? _timer;
  final smartAuth = SmartAuth.instance;
  void getSmsWithUserConsentApi() async {
    final res = await smartAuth.getSmsWithUserConsentApi();
    if (res.hasData) {
      final code = res.requireData.code;
      if (code == null) return;
      setState(() {
        widget.otpController.text = code;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.otpController.addListener(_checkInput);
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.otpController.removeListener(_checkInput);
    super.dispose();
  }

  void _checkInput() {
    setState(() {
      active = widget.otpController.text.length == 6;
    });
  }

  void _startCountdown() {
    setState(() {
      _isButtonEnabled = false;
      _secondsRemaining = 60;
    });

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isButtonEnabled = true;
        });
        _timer?.cancel();
      }
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
              maxInputSize: 6,
              inputType: TextInputType.phone,
              hintText: "Enter Otp",
              obscureText: true,
              error: widget.error,
            ),
          ],
        ),
        SizedBox(height: 2),
        TextButton(
          onPressed: _isButtonEnabled
              ? () {
                  _startCountdown();
                }
              : null,
          child: Text(
            _isButtonEnabled
                ? "Resend Code"
                : "Resend code in $_secondsRemaining seconds",
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
              text: widget.firstTimeUser ? 'Next →' : 'Login',
              loading: widget.loading),
        ),
      ],
    );
  }
}
