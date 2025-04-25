import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nokasa_user/models/user.dart';
import 'package:nokasa_user/resources/auth_methods.dart';
import 'package:nokasa_user/utils/utils.dart';
import 'package:nokasa_user/widget/custom_app_bar.dart';
import 'package:nokasa_user/widget/green_button.dart';
import 'package:nokasa_user/widget/profile_text_input.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String nameError = "";
  String phoneError = "";
  bool name=false;
  bool phone=false;
  void save() {
    AuthMethods().updateUserDetails(
        name: _nameController.text, phoneNumber: "+91${_phoneController.text}");
    showSnackBar(context, "Details Updated Successfully");
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  void getUserDeails() async {
    User data = await AuthMethods().getUserDetails();
    setState(() {
      _nameController.text = data.name;
      _phoneController.text = data.phoneNumber.substring(3);
    });
  }
  void nameListner(){
    setState(() {
      name=_nameController.text.length>3;
    });
  }
  void phoneListner(){
    setState(() {
      phone=_phoneController.text.length==10;
    });
    print(name && phone);
  }
  @override
  void initState() {
    super.initState();
    _nameController.addListener(nameListner);
    _phoneController.addListener(phoneListner);
    getUserDeails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
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
                  SizedBox(
                    child: ProfileTextInput(
                      labelText: "Name",
                      textEditingController: _nameController,
                      error: nameError,
                      prefixText: "",
                      hintText: "John Doe",
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileTextInput(
                    labelText: "Phone",
                    textEditingController: _phoneController,
                    error: phoneError,
                    prefixText: "+91 ",
                    hintText: "9876543210",
                    maxSize: 10,
                    textInputType: TextInputType.phone,
                  ),
                ],
              ),
              Spacer(),
              GreenButton(
                onPressed: save,
                isActive: name && phone,
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
