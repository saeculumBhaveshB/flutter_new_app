import 'package:flutter/material.dart';
import 'package:nokasa_user/resources/auth_methods.dart';
import 'package:nokasa_user/screen/home/home.dart';
import 'package:nokasa_user/utils/navigation.dart';
import 'package:nokasa_user/widget/text/heading_text.dart';
import 'package:nokasa_user/widget/input/name_input_widget.dart';

class NameInput extends StatefulWidget {
  const NameInput({super.key});
  @override
  State<NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  final TextEditingController _nameController = TextEditingController();
  String error = "";
  bool isLoading = false;
  void next() async {
    setState(() {
      isLoading = true;
    });
    await AuthMethods().updateUserDetails(name: _nameController.text);
    if(mounted){
      Navigation().emptyStack(context, Home());
    }
    

    setState(() {
      isLoading = false;
    });
  }

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
                HeadingText(text: "Anon, what’s your name?"),
                SizedBox(height: 30),
                NameInputWidget(
                  nameController: _nameController,
                  next: next,
                  loading: isLoading,
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
