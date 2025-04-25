import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/bluethooth/connected.dart';
import 'package:nokasa_user/screen/error/bluethooth_not_connected.dart';
import 'package:nokasa_user/utils/ble.dart';
import 'package:nokasa_user/widget/custom_app_bar.dart';
import 'package:nokasa_user/widget/bluetooth/bluethooth_page_image.dart';
import 'package:nokasa_user/widget/text/fig_tree_text.dart';

class Connecting extends StatefulWidget {
  const Connecting({super.key});

  @override
  State<Connecting> createState() => _ConnectingState();
}

class _ConnectingState extends State<Connecting> {
  bool isScanning = false;
  final Ble bluetoothState=Ble();

  void navigateToNextScreen(Widget nextPage) {
    Navigator.of(context).maybePop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }

  void connect() async{
    bool result=await bluetoothState.connectToSmartBin();
    if(result){
      navigateToNextScreen(Connected(bluetoothState: bluetoothState,));
    }
    else{
      navigateToNextScreen(BluethoothNotConnected());
    }
  }

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BluethoothPageImage(imageUrl: "assets/images/Search.gif"),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    FigtreeText(
                        text: "Looking for the NoKasa Smart Bin", fontSize: 23),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: FigtreeText(
                          text: "Wait while we find the Nokasa Smart Bin near you",
                          fontSize: 18,
                          textColor: Color.fromRGBO(79, 79, 79, 1.0)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
