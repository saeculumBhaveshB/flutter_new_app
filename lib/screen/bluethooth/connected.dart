import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/bluethooth/place_your_bags.dart';
import 'package:nokasa_user/utils/ble.dart';
import 'package:nokasa_user/widget/bluetooth/bluethooth_page_image.dart';
import 'package:nokasa_user/widget/text/fig_tree_text.dart';

class Connected extends StatefulWidget {
  final Ble bluetoothState;
  const Connected({super.key,required this.bluetoothState});

  @override
  State<Connected> createState() => _ConnectedState();
}

class _ConnectedState extends State<Connected> {
  Timer? _timer;
  
  void navigateToNextScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => PlaceYourBags(bluethoothState: widget.bluetoothState,)),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), navigateToNextScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: navigateToNextScreen,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BluethoothPageImage(imageUrl: "assets/images/Celebrate.gif"),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  FigtreeText(text: "Connected!", fontSize: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
