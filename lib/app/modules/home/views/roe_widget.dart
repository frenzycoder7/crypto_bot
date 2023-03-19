import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ROEWidget extends StatelessWidget {
  ROEWidget(
      {super.key,
      required this.currentPrice,
      required this.entryPrice,
      required this.leverage,
      required this.qty});
  double qty;
  double entryPrice;
  int leverage;
  double currentPrice;
  @override
  Widget build(BuildContext context) {
    return Text(
      '${((((num.parse(currentPrice.toString()) - num.parse(entryPrice.toString())) * num.parse(qty.toString())) / (num.parse(qty.toString()) * num.parse(entryPrice.toString()) * (1 / num.parse(leverage.toString())))) * 100).toDouble().toPrecision(2)} %',
      style: TextStyle(
        fontSize: 20,
        color: ((currentPrice - entryPrice) * qty) /
                    (qty * entryPrice * (1 / leverage)) >
                0
            ? Colors.greenAccent
            : Colors.redAccent,
      ),
    );
  }
}
