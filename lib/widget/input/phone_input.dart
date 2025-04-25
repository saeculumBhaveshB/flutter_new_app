import 'package:flutter/material.dart';
import 'package:nokasa_user/widget/green_button.dart';
import 'package:nokasa_user/widget/green_line_input.dart';
import 'package:smart_auth/smart_auth.dart';

class PhoneInput extends StatefulWidget {
  final TextEditingController phoneController;
  final Future<void> Function() next;
  final bool loading;
  final String error;
  const PhoneInput(
      {super.key,
      required this.phoneController,
      required this.next,
      required this.loading,
      required this.error});

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  bool active = false;
  final smartAuth = SmartAuth.instance;
  bool hintOpen = false;
  void open() {
    if (hintOpen) return;
    hintOpen = true;
    requestPhoneNumberHint();
  }

  void requestPhoneNumberHint() async {
    final res = await smartAuth.requestPhoneNumberHint();
    if (res.hasData) {
      String cleanedNumber = (res.data ?? "").replaceAll(RegExp(r'\D'), '');

      if ((res.data ?? "").startsWith("+91")) {
        cleanedNumber = cleanedNumber.substring(2);
      } else if (cleanedNumber.startsWith("0")) {
        cleanedNumber = cleanedNumber.substring(1);
      }
      setState(() {
        widget.phoneController.text = cleanedNumber;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.phoneController.addListener(_checkInput);
  }

  @override
  void dispose() {
    widget.phoneController.removeListener(_checkInput);
    super.dispose();
  }

  void _checkInput() {
    setState(() {
      active = widget.phoneController.text.length == 10;
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
              controller: widget.phoneController,
              maxInputSize: 10,
              inputType: TextInputType.phone,
              hintText: "Enter Phone Number",
              onClick: open,
              error: widget.error,
              phoneInput: true,
            ),
          ],
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
