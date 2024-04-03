import 'package:card_transactions/domain/transaction.dart';
import 'package:flutter/material.dart';

class SingleDayTransaction extends StatelessWidget {
  final DateTime date;
  final double? size;
  final double? margin;
  final double? borderRadius;
  final List<Transaction> transactions;
  const SingleDayTransaction(
      {super.key,
      required this.date,
      required this.transactions,
      this.size,
      this.margin,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 20,
      width: size ?? 20,
      margin: EdgeInsets.all(margin ?? 2),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius ?? 4),
        ),
      ),
    );
  }
}
