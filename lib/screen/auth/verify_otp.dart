import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nokasa_user/resources/auth_methods.dart';
import 'package:nokasa_user/screen/auth/signup/name_input.dart';
import 'package:nokasa_user/screen/home/home.dart';
import 'package:nokasa_user/utils/config.dart';
import 'package:nokasa_user/utils/navigation.dart';
import 'package:nokasa_user/widget/custom_app_bar.dart';
import 'package:nokasa_user/widget/text/heading_text.dart';
import 'package:nokasa_user/widget/input/otp_input.dart';
import 'package:http/http.dart' as http;

class VerifyOtp extends StatefulWidget {
  final String phoneNumber;
  final bool newUser;
  const VerifyOtp(
      {super.key, required this.phoneNumber, required this.newUser});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final TextEditingController _otpController = TextEditingController();
  bool loading = false;
  String error = "";
  Future<void> signIn() async {
    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
          Uri.parse(
              '${Config.baseUrl}${widget.newUser ? "signup" : "signin"}/verify-otp'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(
              {"phoneNumber": widget.phoneNumber, "otp": _otpController.text}));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await AuthMethods().loginUser(token: data['firebaseToken'] ?? "");
        if (mounted) {
          Navigation().emptyStack(context, widget.newUser ? NameInput() : Home());
          
        }
      } else {
        final errorData = json.decode(response.body);
        setState(() {
          error = errorData['message'] ??
              errorData['error'] ??
              'An unknown error occurred.';
        });
      }
    } catch (err) {
      setState(() {
        error = err.toString();
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeadingText(text: "Enter the code sent to your number"),
                SizedBox(height: 30),
                OtpInput(
                    otpController: _otpController,
                    next: signIn,
                    loading: loading,
                    firstTimeUser: true,
                    error: error),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
