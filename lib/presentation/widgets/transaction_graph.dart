import 'dart:math';

import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/presentation/widgets/month_label.dart';
import 'package:card_transactions/presentation/widgets/single_day.dart';
import 'package:card_transactions/presentation/widgets/week_label.dart';
import 'package:card_transactions/utils.dart';
import 'package:flutter/material.dart';

class TransactionGraph extends StatelessWidget {
  const TransactionGraph(
      {super.key,
      required this.onPressDay,
      required this.transactionData,
      this.startDate,
      this.endDate,
      this.size = 20,
      this.fontSize = 12,
      this.margin = 2,
      this.baseColor,
      this.noTransactionColor,
      this.weekLableVisiblityType = WeekLableVisiblityType.all,
      this.monthLabelVisiblityType = MonthLabelVisiblityType.short});

  final DateTime? startDate;
  final DateTime? endDate;
  final Map<DateTime, List<Transaction>> transactionData;
  final double? size;
  final double? fontSize;
  final double? margin;
  final Color? noTransactionColor;
  final Color? baseColor;
  final WeekLableVisiblityType weekLableVisiblityType;
  final MonthLabelVisiblityType monthLabelVisiblityType;
  final Function(List<Transaction>, DateTime) onPressDay;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MonthLabel(
              startDate: startDate ?? DateTime.now(),
              monthLabelVisiblityType: monthLabelVisiblityType,
              fontSize: fontSize ?? 12),
          Row(
            children: [
              WeekLabel(
                weekLableVisiblityType: weekLableVisiblityType,
                fontSize: fontSize ?? 12,
                size: size ?? 20,
                margin: margin ?? 2,
              ),
              ..._buildWeeks()
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildWeeks() {
    List<Widget> weeks = [];
    DateTime today = startDate ?? DateTime.now();
    DateTime aYearBack = endDate ?? today.copyWith(year: today.year - 1);
    int totalDays = today.difference(aYearBack).inDays;

    int firstDay = aYearBack.weekday;

    double maxTransactionPerDay = 0;
    transactionData.forEach((key, value) {
      maxTransactionPerDay = max(
          maxTransactionPerDay,
          value.fold(
              0.0, (previousValue, element) => previousValue + element.amount));
    });

    int startOfLoop = 0;
    if (firstDay != 7) {
      startOfLoop = 7 - firstDay;

      weeks.add(_firstWeek(firstDay, aYearBack, maxTransactionPerDay));
    }

    for (int day = startOfLoop; day < totalDays; day += 7) {
      DateTime weekStartDate = aYearBack.copyWith(day: aYearBack.day + day);
      DateTime weekEndDate = (day >= totalDays - 7)
          ? today
          : aYearBack.copyWith(day: aYearBack.day + day + 7);
      int dayDifference = weekEndDate.difference(weekStartDate).inDays;
      weeks.add(Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
            dayDifference < 7 ? dayDifference + 1 : dayDifference,
            (index) => SingleDayTransaction(
              date: weekStartDate.copyWith(day: weekStartDate.day + index),
              maxTransactionPerDay: maxTransactionPerDay,
              noTransactionColor: noTransactionColor,
              baseColor: baseColor,
              onPress: onPressDay,
              transactions: transactionData[weekStartDate.copyWith(
                      day: weekStartDate.day + index,
                      hour: 0,
                      minute: 0,
                      microsecond: 0,
                      second: 0,
                      millisecond: 0)] ??
                  [],
            ),
          ),
          if (dayDifference < 7)
            ...List.generate(
              7 - (dayDifference < 7 ? dayDifference + 1 : dayDifference),
              (index) => Container(
                height: 20,
                width: 20,
                margin: EdgeInsets.all(margin ?? 2),
              ),
            ),
        ],
      ));
    }
    return weeks;
  }

  Widget _firstWeek(
      int initialEmptyDays, DateTime startDate, double maxTransactionPerDay) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          initialEmptyDays,
          (index) => Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.all(margin ?? 2),
          ),
        ),

        // rest days use increment to
        ...List.generate(
          7 - initialEmptyDays,
          (index) => SingleDayTransaction(
            date: startDate.copyWith(day: startDate.day + index),
            maxTransactionPerDay: maxTransactionPerDay,
            noTransactionColor: noTransactionColor,
            baseColor: baseColor,
            onPress: onPressDay,
            transactions: transactionData[startDate.copyWith(
                    day: startDate.day + index,
                    hour: 0,
                    minute: 0,
                    microsecond: 0,
                    second: 0,
                    millisecond: 0)] ??
                [],
          ),
        ),
      ],
    );
  }
}
