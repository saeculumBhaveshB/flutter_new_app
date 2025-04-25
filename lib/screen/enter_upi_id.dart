import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/thank_you.dart';
import 'package:nokasa_user/widget/custom_app_bar.dart';
import 'package:nokasa_user/widget/input/upi_input.dart';
import 'package:nokasa_user/widget/text/heading_text.dart';

class EnterUpiId extends StatefulWidget {
  const EnterUpiId({
    super.key,
  });

  @override
  State<EnterUpiId> createState() => _EnterUpiIdState();
}

class _EnterUpiIdState extends State<EnterUpiId> {
  final TextEditingController _upiController = TextEditingController();
  String error = "";
  bool loading = false;
  Future<void> submit() async {
    setState(() {
      loading = true;
    });
    setState(() {
      loading = false;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ThankYou()));
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
                HeadingText(text: "Enter your UPI ID to get cashback"),
                SizedBox(height: 30),
                UpiInput(
                  otpController: _upiController,
                  next: submit,
                  loading: loading,
                  error: error,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
