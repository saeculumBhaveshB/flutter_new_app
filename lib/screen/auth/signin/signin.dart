import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/auth/signup/signup.dart';
import 'package:nokasa_user/screen/auth/verify_otp.dart';
import 'package:nokasa_user/utils/colors.dart';
import 'package:nokasa_user/utils/config.dart';
import 'package:nokasa_user/widget/text/heading_text.dart';
import 'package:nokasa_user/widget/input/phone_input.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _phoneController = TextEditingController();
  String error = "";
  Future<void> next() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response =
          await http.post(Uri.parse('${Config.baseUrl}signin/sent-otp'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: json.encode({
                "phoneNumber": _phoneController.text,
              }));
      if (response.statusCode == 200) {
        if (mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOtp(
                      phoneNumber: _phoneController.text, newUser: false)));
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
        error = "Something went wrong";
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeadingText(text: "Hello. What's your phone number?"),
                SizedBox(height: 30),
                PhoneInput(
                  phoneController: _phoneController,
                  next: next,
                  loading: isLoading,
                  error: error,
                ),
                if (error.isNotEmpty)
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: "New user? ",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    children: [
                      TextSpan(
                        text: "SignUp",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
