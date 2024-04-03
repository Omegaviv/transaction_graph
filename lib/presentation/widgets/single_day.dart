import 'package:card_transactions/constants.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:flutter/material.dart';

class SingleDayTransaction extends StatelessWidget {
  final DateTime date;
  final double? size;
  final double? margin;
  final double? borderRadius;
  final Color? noTransactionColor;
  final Color? baseColor;
  final List<Transaction> transactions;
  final double maxTransactionPerDay;
  final Function(List<Transaction>, DateTime) onPress;
  const SingleDayTransaction(
      {super.key,
      required this.date,
      required this.transactions,
      required this.maxTransactionPerDay,
      required this.onPress,
      this.noTransactionColor,
      this.baseColor,
      this.size,
      this.margin,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress(transactions, date);
      },
      child: Container(
        height: size ?? 20,
        width: size ?? 20,
        margin: EdgeInsets.all(margin ?? 2),
        decoration: BoxDecoration(
          color: transactions.isEmpty
              ? noTransactionColor ?? Constants.NO_TRANSACTION_COLOR
              : (baseColor ?? Constants.BRAND_COLOR)
                  .withOpacity(totalAmount() / maxTransactionPerDay),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? 4),
          ),
        ),
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
