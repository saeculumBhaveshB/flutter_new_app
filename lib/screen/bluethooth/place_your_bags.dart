import 'package:flutter/material.dart';
import 'package:nokasa_user/resources/auth_methods.dart';
import 'package:nokasa_user/screen/bluethooth/finish_order.dart';
import 'package:nokasa_user/screen/error/no_enough_bags.dart';
import 'package:nokasa_user/utils/ble.dart';
import 'package:nokasa_user/utils/colors.dart';
import 'package:nokasa_user/widget/bluetooth/bluethooth_page_image.dart';
import 'package:nokasa_user/widget/custom_app_bar.dart';
import 'package:nokasa_user/widget/green_button.dart';
import 'package:nokasa_user/widget/text/fig_tree_text.dart';
import 'package:nokasa_user/widget/text/heading_text.dart';

class PlaceYourBags extends StatefulWidget {
  final Ble bluethoothState;
  const PlaceYourBags({super.key,required this.bluethoothState});

  @override
  State<PlaceYourBags> createState() => _PlaceYourBagsState();
}
class _PlaceYourBagsState extends State<PlaceYourBags> {
  List<num> weight=[];
  void next() async{
    List<num> weights=await widget.bluethoothState.stopWeighing();
    setState(() {
      weight=weights;
    });
    if(!mounted){
      return;
    }
    if(weights.isNotEmpty) {
        Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => FinishOrder(weight:weight,binId: widget.bluethoothState.getBinId(),)),
    );
      
    }
    else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>NoEnoughBags()));
    }
    
  }

  bool weightMeasuring = false;
  @override
  Widget build(BuildContext context) {
    void firstClick() {
      String userId=AuthMethods().getuserId();
      widget.bluethoothState.startWeighing(userId);
      setState(() {
        weightMeasuring = true;
      });
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              HeadingText(text: "Place your bags on the scale"),
              SizedBox(
                height: 40,
              ),
              BluethoothPageImage(imageUrl: "assets/images/weight_icon.png"),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: FigtreeText(
                  text: "Wait for the beep before dropping the bag into bin",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  textColor: grey2,
                ),
              ),
              Spacer(),
              GreenButton(
                  onPressed: weightMeasuring ? next : firstClick,
                  isActive: true,
                  text: weightMeasuring ? "Finish Order" : "Start my Order",
                  loading: false),
            ],
          ),
        ),
      ),
    );
  }
}
