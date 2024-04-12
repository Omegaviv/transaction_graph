import 'package:card_transactions/constants.dart';
import 'package:card_transactions/cotrollers/transaction_controller.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/presentation/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleDayTransaction extends StatelessWidget {
  final DateTime date;
  final double? size;
  final double? margin;
  final double? borderRadius;
  final Color? noTransactionColor;
  final Color? baseColor;
  final List<Transaction> transactions;

  // Over all max spend a day, throughtout the year
  final double maxTransactionPerDay;

  const SingleDayTransaction(
      {super.key,
      required this.date,
      required this.transactions,
      required this.maxTransactionPerDay,
      this.noTransactionColor,
      this.baseColor,
      this.size,
      this.margin,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();
    return GestureDetector(
      onTap: () {
        transactionController.updateSelecedDate(date);
        List<Transaction> transactions =
            transactionController.getTransactionSelectedDate();
        Get.to(Transactionpage(
          transactions: transactions,
          date: transactionController.selectedDate.value,
          totalAmount: transactionController.selectedDayTotal(transactions),
        ));
      },
      child: Container(
        height: size ?? 20,
        width: size ?? 20,
        margin: EdgeInsets.all(margin ?? 2),
        decoration: BoxDecoration(
            color: transactions.isEmpty
                ? noTransactionColor ?? Constants.NO_TRANSACTION_COLOR
                : (baseColor ?? Constants.BRAND_COLOR)
                    .withOpacity((totalAmount() / maxTransactionPerDay)),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 4),
            ),
            border: Border.all(color: Colors.white, width: 0.5)),
      ),
    );
  }

  double totalAmount() {
    double sum = 0;
    for (var element in transactions) {
      sum += element.amount;
    }
    return sum;
  }
}
