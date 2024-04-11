import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactonWidget extends StatelessWidget {
  const TransactonWidget({super.key, required this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Icon(
              transaction.type == TransactionType.credit
                  ? Icons.arrow_downward_outlined
                  : Icons.arrow_upward_outlined,
              color: Colors.black.withOpacity(0.6),
              size: 17,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.name,
                style: const TextStyle(fontSize: 13),
              ),
              Text(
                DateFormaters.to12Hrs(transaction.time),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          '₹${transaction.amount.toPrecision(2)}',
          style: const TextStyle(fontSize: 13),
        )
      ],
    );
  }
}
