import 'package:card_transactions/constants.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/presentation/widgets/transaction_widget.dart';
import 'package:card_transactions/utils.dart';
import 'package:flutter/material.dart';

class Transactionpage extends StatelessWidget {
  const Transactionpage({
    super.key,
    required this.transactions,
    required this.date,
    required this.totalAmount,
  });
  final List<Transaction> transactions;
  final DateTime date;
  final double totalAmount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transactions',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormaters.toDDMMMYYYY(date),
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                  key: const Key(Constants.FULL_DISPLAY_DATE),
                ),
                Text(
                  "₹$totalAmount",
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                  key: const Key(Constants.TOTAL_AMOUNT),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 7,
            ),
            if (transactions.isEmpty)
              const Center(
                child: Text("No Transaction here."),
              ),
            if (transactions.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: transactions.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Padding(
                    key: Key(transactions[index].id),
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: TransactonWidget(transaction: transactions[index]),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
