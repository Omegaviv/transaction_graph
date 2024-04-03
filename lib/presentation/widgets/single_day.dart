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
  String dateFormat() {
    return '${Constants.MONTH_LABEL[date.month - 1]} ${date.day}';
  }

  void _showTooltipPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(transactions.isEmpty
              ? 'No transaction on this day'
              : 'Transactions of ${dateFormat()}'),
          content: transactions.isEmpty
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...transactions.map(
                        (e) => Text("Spent ${e.amount}, Trans Id: ${e.id}"))
                  ],
                ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showTooltipPopup(context);
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
