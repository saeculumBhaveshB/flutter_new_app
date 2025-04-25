import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nokasa_user/models/user.dart';
import 'package:nokasa_user/resources/auth_methods.dart';
import 'package:nokasa_user/utils/colors.dart';
import 'package:nokasa_user/utils/utils.dart';
import 'package:nokasa_user/widget/custom_app_bar.dart';
import 'package:nokasa_user/widget/green_button.dart';
import 'package:nokasa_user/widget/profile_text_input.dart';
import 'package:nokasa_user/widget/text/fig_tree_text.dart';

class EditUpiid extends StatefulWidget {
  const EditUpiid({super.key});

  @override
  State<EditUpiid> createState() => _EditUpiidState();
}

class _EditUpiidState extends State<EditUpiid> {
  final TextEditingController _upiIdController = TextEditingController();
  String nameError = "";
  String phoneError = "";

  void save() {
    AuthMethods().updateUserDetails(upiID: _upiIdController.text);
    showSnackBar(context, "Details Updated Successfully");
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  void getUserDeails() async {
    User data = await AuthMethods().getUserDetails();
    setState(() {
      _upiIdController.text = data.upiID;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDeails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                children: [
                  FigtreeText(
                    text: "Enter your UPI ID",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    textColor: grey2,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: ProfileTextInput(
                      labelText: "UPI ID",
                      textEditingController: _upiIdController,
                      error: nameError,
                      prefixText: "",
                      hintText: "John Doe",
                    ),
                  ),
                ],
              ),
              Spacer(),
              GreenButton(
                onPressed: save,
                isActive: true,
                text: "Save",
                loading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
