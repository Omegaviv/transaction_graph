import 'package:card_transactions/constants.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/presentation/widgets/single_day.dart';
import 'package:card_transactions/presentation/widgets/week_label.dart';
import 'package:flutter/material.dart';

enum WeekLableVisiblityType { none, oddDays, evenDays, all }

class TransactionGraph extends StatelessWidget {
  const TransactionGraph(
      {super.key,
      this.startDate,
      this.endDate,
      required this.transactionData,
      this.size = 20,
      this.fontSize = 12,
      this.margin = 2,
      this.weekLableVisiblityType = WeekLableVisiblityType.all});

  final DateTime? startDate;
  final DateTime? endDate;
  final List<Transaction> transactionData;
  final double? size;
  final double? fontSize;
  final double? margin;
  final WeekLableVisiblityType weekLableVisiblityType;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
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
    );
  }

  List<Widget> _buildWeeks() {
    List<Widget> weeks = [];
    DateTime today = startDate ?? DateTime.now();
    DateTime aYearBack = endDate ?? today.copyWith(year: today.year - 1);
    int totalDays = today.difference(aYearBack).inDays;

    int firstDay = aYearBack.weekday;

    int startOfLoop = 0;
    if (firstDay != 7) {
      startOfLoop = 7 - firstDay;

      weeks.add(_firstWeek(firstDay, aYearBack));
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
              transactions: const [],
            ),
          ),
          if (dayDifference < 7)
            ...List.generate(
              7 - (dayDifference < 7 ? dayDifference + 1 : dayDifference),
              (index) => Container(
                height: 20,
                width: 20,
                color: Colors.grey,
                margin: const EdgeInsets.all(2),
              ),
            ),
        ],
      ));
    }
    return weeks;
  }

  Widget _firstWeek(int initialEmptyDays, DateTime startDate) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          initialEmptyDays,
          (index) => Container(
            height: 20,
            width: 20,
            color: Colors.grey,
            margin: const EdgeInsets.all(2),
          ),
        ),

        // rest days use increment to
        ...List.generate(
          7 - initialEmptyDays,
          (index) => SingleDayTransaction(
            date: startDate.copyWith(day: startDate.day + index),
            transactions: const [],
          ),
        ),
      ],
    );
  }
}
