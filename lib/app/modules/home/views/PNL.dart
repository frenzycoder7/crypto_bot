import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PnlWidget extends StatelessWidget {
  PnlWidget({
    super.key,
    required this.entryPrice,
    required this.marketPrice,
    required this.qty,
  });
  double marketPrice;
  double entryPrice;
  double qty;
  @override
  Widget build(BuildContext context) {
    return Text(
      '${((num.parse(marketPrice.toString()) - num.parse(entryPrice.toString())) * num.parse(qty.toString())).toDouble().toPrecision(2)}',
      style: TextStyle(
        fontSize: 20,
        color: ((marketPrice - entryPrice) * qty) > 0
            ? Colors.greenAccent
            : Colors.redAccent,
      ),
    );
  }
}
