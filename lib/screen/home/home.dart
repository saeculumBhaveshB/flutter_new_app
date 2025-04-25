import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokasa_user/models/const_values.dart';
import 'package:nokasa_user/models/user.dart';
import 'package:nokasa_user/resources/auth_methods.dart';
import 'package:nokasa_user/resources/const_values_ratio.dart';
import 'package:nokasa_user/screen/bluethooth/how_to_deposit.dart';
import 'package:nokasa_user/screen/home/widget/home_navbar.dart';
import 'package:intl/intl.dart';
import 'package:nokasa_user/screen/home/widget/info_box.dart';
import 'package:nokasa_user/screen/past_order/orders.dart';
import 'package:nokasa_user/utils/colors.dart';
import 'package:nokasa_user/utils/helper_functions.dart';
import 'package:nokasa_user/widget/home/home_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = "Prince";
  num wasteDiverted = 810503;
  num water = 0;
  num power = 0;
  num oil = 0;
  num trees = 0;
  num totalCloth = 0;
  String convertNumberToString(num number) {
    return NumberFormat('##,##,##,###').format(number);
  }

  void getUserInfo() async {
    User data = await AuthMethods().getUserDetails();
    setState(() {
      userName = data.name;
      totalCloth = data.totalClothWeight;
    });
  }

  void getConstValues() async{
    ConstValues values=await ConstValuesRatio().getValues();
    setState(() {
      water=values.water;
      power=values.power;
      oil=values.oil;
      trees=values.tree;
      wasteDiverted=values.waste;
    });
  }
  @override
  void initState() {
    super.initState();
    getUserInfo();
    getConstValues();
  }

  @override
  Widget build(BuildContext context) {
    String wasteDivertedString = convertNumberToString(wasteDiverted);

    return Scaffold(
        // backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          automaticallyImplyLeading: false,
          title: HomeNavbar(name: userName),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset("assets/images/home.png"),
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        children: [
                          Text(
                            wasteDivertedString,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Recoleta',
                              fontSize: 48,
                              height: 1.2,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            "kilograms waste diverted from landfills",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.figtree(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 22,
                              height: 1.2,
                              letterSpacing: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InfoBox(
                            iconUrl: "assets/images/drop.png",
                            heading1: HelperFunctions().formatCompactIndian(power*totalCloth),
                            heading2: "litres of water",
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: InfoBox(
                            iconUrl: "assets/images/power.png",
                            heading1: HelperFunctions().formatCompactIndian(power*totalCloth),
                            heading2: "KWH of power",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InfoBox(
                            iconUrl: "assets/images/oil.png",
                            heading1: HelperFunctions().formatCompactIndian(oil*totalCloth),
                            heading2: "litres of oil",
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: InfoBox(
                            iconUrl: "assets/images/tree.png",
                            heading1: HelperFunctions().formatCompactIndian(trees*totalCloth),
                            heading2: "CO2 emissions",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                HomeButton(
                  destination: HowToDeposit(),
                  buttonText: "New Orders",
                ),
                SizedBox(
                  height: 10,
                ),
                HomeButton(
                  destination: Orders(),
                  buttonText: "Past Orders",
                  buttonColor: Colors.orange,
                ),
              ],
            ),
          ),
        ));
  }
}
