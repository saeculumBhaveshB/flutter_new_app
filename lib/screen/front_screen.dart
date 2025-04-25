import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/auth/signup/signup.dart';
import 'package:nokasa_user/utils/colors.dart';
import 'package:nokasa_user/widget/bluetooth/bluethooth_page_image.dart';
import 'package:nokasa_user/widget/front_page/page_no.dart';
import 'package:nokasa_user/widget/green_button.dart';
import 'package:nokasa_user/widget/text/fig_tree_text.dart';
import 'package:nokasa_user/widget/text/heading_text.dart';

class OnboardingStep {
  final String headingText;
  final String imageUrl;
  final String bottomText;

  OnboardingStep({
    required this.headingText,
    required this.imageUrl,
    required this.bottomText,
  });
}

class FrontScreen extends StatefulWidget {
  const FrontScreen({super.key});

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  final List<OnboardingStep> onboardingSteps = [
    OnboardingStep(
      headingText: "A Greener Future Starts Here",
      imageUrl: "assets/images/front1.png",
      bottomText: "Connect to bin to get started with your green journey",
    ),
    OnboardingStep(
      headingText: "Fill It and Drop It",
      imageUrl: "assets/images/front2.png",
      bottomText: "Fill the bag with your clothes and drop it in the box",
    ),
    OnboardingStep(
      headingText: "Turn Clothes Into Cashback",
      imageUrl: "assets/images/front3.png",
      bottomText: "Get exciting cash rewards for your returned clothes",
    ),
    OnboardingStep(
      headingText: "Clothes Reused. Future Renewed.",
      imageUrl: "assets/images/front4.png",
      bottomText: "We reuse responsibly and give your clothes a new life",
    ),
  ];

  int screen = 0;
  void goToSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  void screenChange() {
    if (screen == 3) {
      goToSignUp();
    } else {
      setState(() {
        screen++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: List.generate(
            4,
            (index) => Expanded(child: PageNo(active: screen == index)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
                width: 300,
                child: HeadingText(text: onboardingSteps[screen].headingText)),
            SizedBox(
              height: 30,
            ),
            BluethoothPageImage(imageUrl: onboardingSteps[screen].imageUrl),
            SizedBox(height: 10),
            SizedBox(
                width: 250,
                child: FigtreeText(
                    text: onboardingSteps[screen].bottomText, fontSize: 18)),
            Spacer(),
            GreenButton(
                onPressed: screenChange,
                isActive: true,
                text: "Next",
                loading: false),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: goToSignUp,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
