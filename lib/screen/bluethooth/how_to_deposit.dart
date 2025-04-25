import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/bluethooth/connecting.dart';
import 'package:nokasa_user/widget/green_button.dart';

class HowToDeposit extends StatelessWidget {
  const HowToDeposit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/how_it_works.png',
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GreenButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Connecting()),
                        );
                      },
                      isActive: true,
                      text: "Next →",
                      loading: false,
                    ),
                  ],
                ),
              Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: () {
                      print("Back tapped");
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      
                      child: const Icon(Icons.arrow_back, size: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
