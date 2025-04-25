import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/enter_upi_id.dart';
import 'package:nokasa_user/widget/celebration/cashback_widget.dart';
import 'package:nokasa_user/widget/celebration/celebration.dart';

class GetCashback extends StatefulWidget {
  final double amount;
  const GetCashback({super.key, required this.amount});

  @override
  State<GetCashback> createState() => _GetCashbackState();
}

class _GetCashbackState extends State<GetCashback> {
  @override
  Widget build(BuildContext context) {
    return Celebration(
        buttonText: "Get Cashback",
        destination: EnterUpiId(),
        middleWidget: CashbackWidget(amount: widget.amount));
  }
}
