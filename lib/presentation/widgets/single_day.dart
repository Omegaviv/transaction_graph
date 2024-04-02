import 'package:card_transactions/domain/transaction.dart';
import 'package:flutter/material.dart';

class SingleDayTransaction extends StatelessWidget {
  final DateTime date;
  final List<Transaction> transactions;
  const SingleDayTransaction(
      {super.key, required this.date, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.all(2),
      color: Colors.blue,
      child: Text(date.day.toString()),
    );
  }
}
