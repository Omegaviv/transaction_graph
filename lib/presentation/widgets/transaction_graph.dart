import 'dart:math';

import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/presentation/widgets/custom_animation.dart';
import 'package:card_transactions/presentation/widgets/month_label.dart';
import 'package:card_transactions/presentation/widgets/single_day.dart';
import 'package:card_transactions/presentation/widgets/week_label.dart';
import 'package:card_transactions/utils.dart';
import 'package:flutter/material.dart';

class TransactionGraph extends StatelessWidget {
  const TransactionGraph(
      {super.key,
      required this.transactionData,
      this.startDate,
      this.size = 20,
      this.fontSize = 12,
      this.margin = 2,
      this.baseColor,
      this.noTransactionColor,
      this.weekLableVisiblityType = WeekLableVisiblityType.all,
      this.monthLabelVisiblityType = MonthLabelVisiblityType.short});

  final DateTime? startDate;
  final Map<DateTime, List<Transaction>> transactionData;
  final double? size;
  final double? fontSize;
  final double? margin;
  final Color? noTransactionColor;
  final Color? baseColor;
  final WeekLableVisiblityType weekLableVisiblityType;
  final MonthLabelVisiblityType monthLabelVisiblityType;
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MonthLabel(
                startDate: startDate ?? DateTime.now(),
                monthLabelVisiblityType: monthLabelVisiblityType,
                fontSize: fontSize ?? 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WeekLabel(
                  weekLableVisiblityType: weekLableVisiblityType,
                  fontSize: fontSize ?? 12,
                  size: size ?? 20,
                  margin: margin ?? 2,
                ),
                Row(children: [..._buildWeeks()])
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to build all the week of year to show on UI

  List<Widget> _buildWeeks() {
    // This holds list of columns, which will be later children of a row.
    List<Widget> weeks = [];
    DateTime today = startDate ?? DateTime.now();
    DateTime aYearBack = today.copyWith(year: today.year - 1);
    int totalDays = today.difference(aYearBack).inDays;

    int firstDay = aYearBack.weekday;

    // max trancation amount in a day, later to be used for color shade to represent amount spent.
    double maxTransactionPerDay = 0;
    transactionData.forEach((key, value) {
      maxTransactionPerDay = max(
          maxTransactionPerDay,
          value.fold(
              0.0, (previousValue, element) => previousValue + element.amount));
    });

    // if the first day of week is not sunday, to calcualte empty boxes to how on the graph
    int startOfLoop = 0;
    if (firstDay != 7) {
      startOfLoop = 7 - firstDay;

      // UI for first week of the year
      weeks.add(_firstWeek(firstDay, aYearBack, maxTransactionPerDay));
    }

    // for the rest of the week
    for (int day = startOfLoop; day < totalDays; day += 7) {
      // first day of selected week
      DateTime weekStartDate = aYearBack.copyWith(day: aYearBack.day + day);

      // last day of selected week
      DateTime weekEndDate = (day >= totalDays - 7)
          ? today
          : aYearBack.copyWith(day: aYearBack.day + day + 7);
      int dayDifference = weekEndDate.difference(weekStartDate).inDays;

      weeks.add(Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
            dayDifference < 7 ? dayDifference + 1 : dayDifference,
            (index) => SingleDayTransactionAnimation(
              animationUpToSize: (size ?? 20) + (margin ?? 2) * 2,
              dayDifferenceFromStart: day,
              child: SingleDayTransaction(
                key: Key(DateFormaters.toDDMMMYYYYObject(
                        weekStartDate.copyWith(day: weekStartDate.day + index))
                    .toString()),
                date: weekStartDate.copyWith(day: weekStartDate.day + index),
                maxTransactionPerDay: maxTransactionPerDay,
                noTransactionColor: noTransactionColor,
                baseColor: baseColor,
                // Using [Map<DateTime,List<Transaction>>] object to fetch all the transactions done on a day
                transactions: transactionData[DateFormaters.toDDMMMYYYYObject(
                      weekStartDate.copyWith(
                        day: weekStartDate.day + index,
                      ),
                    )] ??
                    [],
              ),
            ),
          ),

          // black days to fill
          if (dayDifference < 7)
            ...List.generate(
              7 - (dayDifference < 7 ? dayDifference + 1 : dayDifference),
              (index) => SingleDayTransactionAnimation(
                animationUpToSize: (size ?? 20) + (margin ?? 2) * 2,
                dayDifferenceFromStart: index,
                child: emptyDay(),
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
        // blank days, days not to display on UI
        ...List.generate(
          initialEmptyDays,
          (index) => SingleDayTransactionAnimation(
            animationUpToSize: (size ?? 20) + (margin ?? 2) * 2,
            dayDifferenceFromStart: index,
            child: emptyDay(),
          ),
        ),

        // days to display on UI
        ...List.generate(
          7 - initialEmptyDays,
          (index) => SingleDayTransactionAnimation(
            animationUpToSize: (size ?? 20) + (margin ?? 2) * 2,
            dayDifferenceFromStart: index,
            child: SingleDayTransaction(
              key: Key(DateFormaters.toDDMMMYYYYObject(
                      startDate.copyWith(day: startDate.day + index))
                  .toString()),
              date: startDate.copyWith(day: startDate.day + index),
              maxTransactionPerDay: maxTransactionPerDay,
              noTransactionColor: noTransactionColor,
              baseColor: baseColor,
              // Using [Map<DateTime,List<Transaction>>] object to fetch all the transactions done on a day
              transactions: transactionData[
                      DateFormaters.toDDMMMYYYYObject(startDate.copyWith(
                    day: startDate.day + index,
                  ))] ??
                  [],
            ),
          ),
        ),
      ],
    );
  }

  Container emptyDay() {
    return Container(
      height: size ?? 20,
      width: size ?? 20,
      margin: EdgeInsets.all(margin ?? 2),
    );
  }
}
