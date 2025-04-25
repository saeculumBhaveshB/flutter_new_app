import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/bluethooth/get_cashback.dart';
import 'package:nokasa_user/utils/colors.dart';
import 'package:nokasa_user/widget/custom_app_bar.dart';
import 'package:nokasa_user/widget/green_button.dart';
import 'package:nokasa_user/widget/text/fig_tree_text.dart';
import 'package:nokasa_user/widget/text/heading_text.dart';

class FinishOrder extends StatefulWidget {
  final List<num> weight;
  final String binId;
  const FinishOrder({super.key,required this.weight,required this.binId});

  @override
  State<FinishOrder> createState() => _FinishOrderState();
}

class _FinishOrderState extends State<FinishOrder> {
  double totalWeight = 0;
  double amountPerKg=10;
  void next() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => GetCashback(amount: (totalWeight*amountPerKg))),
    );
  }

  String sum(List<num> list) {
    double sum = 0;
    for (num n in list) {
      sum += n;
    }
    totalWeight=sum;
    return sum.toString();
  }

  int size = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      size = widget.weight.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          HeadingText(text: "The weight of your clothes is"),
          const SizedBox(height: 20),
          Column(
            children: List.generate(
                size,
                (index) => Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                                child: FigtreeText(
                                  text: "Bag #${index + 1}",
                                  fontSize: 16,
                                  textColor: grey2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: primaryColor,
                                ),
                                padding: EdgeInsets.all(10),
                                child: FigtreeText(
                                  text: "${widget.weight[index]} KG",
                                  fontSize: 14,
                                  textColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (index != size - 1)
                          DottedLine(
                            dashLength: 4,
                            dashGapLength: 5,
                            lineThickness: 1,
                            dashRadius: 1,
                            direction: Axis.horizontal,
                            dashColor: grey2,
                          ),
                      ],
                    )),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 60,
                child: FigtreeText(
                  text: "Total",
                  fontSize: 24,
                  textColor: grey2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              SizedBox(
                width: 80,
                child: FigtreeText(
                  text: "${sum(widget.weight)} KG",
                  fontSize: 20,
                  textColor: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Spacer(),
          GreenButton(
            isActive: true,
            text: "Finish my Order",
            loading: false,
            onPressed: next,
          ),
        ]),
      ),
    );
  }
}
