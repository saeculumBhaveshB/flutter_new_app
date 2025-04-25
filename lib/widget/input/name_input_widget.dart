import 'package:flutter/material.dart';
import 'package:nokasa_user/widget/green_button.dart';
import 'package:nokasa_user/widget/green_line_input.dart';

class NameInputWidget extends StatefulWidget {
  final TextEditingController nameController;
  final void Function() next;
  final bool loading;
  final String error;
  const NameInputWidget(
      {super.key,
      required this.nameController,
      required this.next,
      required this.loading,
      required this.error});

  @override
  State<NameInputWidget> createState() => _NameInputWidgetState();
}

class _NameInputWidgetState extends State<NameInputWidget> {
  bool active = false;

  @override
  void initState() {
    super.initState();
    widget.nameController.addListener(_checkInput);
  }

  @override
  void dispose() {
    widget.nameController.removeListener(_checkInput);
    super.dispose();
  }

  void _checkInput() {
    setState(() {
      active = widget.nameController.text.length >= 3;
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
              controller: widget.nameController,
              maxInputSize: 30,
              hintText: "Enter Your Name",
              error: widget.error,
            )
          ],
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: GreenButton(
              onPressed: widget.next,
              isActive: active,
              text: 'SignUp →',
              loading: widget.loading),
        ),
      ],
    );
  }
}
