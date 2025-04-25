import 'package:flutter/material.dart';
import 'package:nokasa_user/utils/colors.dart';
import 'package:nokasa_user/widget/bluetooth/bluethooth_page_image.dart';
import 'package:nokasa_user/widget/text/fig_tree_text.dart';

class ErrorScreen extends StatelessWidget {
  final String imageUrl;
  final String headingtext;
  final String secondaryText;
  const ErrorScreen(
      {super.key,
      required this.imageUrl,
      required this.headingtext,
      required this.secondaryText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            BluethoothPageImage(imageUrl: imageUrl),
            SizedBox(height: 20,),
            FigtreeText(
              text: headingtext,
              fontSize: 20,
            ),
            SizedBox(height: 20,),
            FigtreeText(
              text: secondaryText,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              textColor: grey2,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
