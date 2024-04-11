import 'package:card_transactions/constants.dart';
import 'package:card_transactions/cotrollers/transaction_controller.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/presentation/widgets/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transactionpage extends StatelessWidget {
  const Transactionpage({super.key});

  String dateFormat(DateTime date) {
    return '${date.day} ${Constants.SHORT_MONTH_LABEL[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();
    final List<Transaction> transactions =
        transactionController.getTransactionSelectedDate();
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
                  dateFormat(transactionController.selectedDate.value),
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                Text(
                    "₹${transactionController.selectedDayTotal(transactions).toString()}",
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500)),
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
