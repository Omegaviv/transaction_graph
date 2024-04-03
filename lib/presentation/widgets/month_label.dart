import 'package:card_transactions/constants.dart';
import 'package:card_transactions/utils.dart';
import 'package:flutter/material.dart';

class MonthLabel extends StatelessWidget {
  const MonthLabel(
      {super.key,
      required this.startDate,
      required this.monthLabelVisiblityType,
      required this.fontSize});
  final DateTime startDate;
  final MonthLabelVisiblityType monthLabelVisiblityType;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    if (monthLabelVisiblityType == MonthLabelVisiblityType.none) {
      return Container();
    }
    List<String> labels =
        monthLabelVisiblityType == MonthLabelVisiblityType.short
            ? Constants.SHORT_MONTH_LABEL
            : Constants.MONTH_LABEL;
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: labels
            .asMap()
            .entries
            .map(
              (e) => SizedBox(
                width: 105,
                child: Text(
                  labels[(e.key + (startDate).month - 1) % 12],
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
