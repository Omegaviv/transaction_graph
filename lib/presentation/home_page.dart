import 'package:card_transactions/presentation/widgets/single_day.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: function(),
        )),
      ),
    );
  }
}

List<Widget> function() {
  List<Widget> listRows = [];
  DateTime today = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 2);
  DateTime aYearBack = today.copyWith(year: today.year - 1);
  int totalDays = today.difference(aYearBack).inDays;

  int firstDay = aYearBack.weekday;

  int startOfCal = 0;
  if (firstDay != 7) {
    startOfCal = 7 - firstDay;

    listRows.add(firstWeekFill(firstDay, aYearBack));
  }

  for (int start = startOfCal; start < totalDays; start += 7) {
    DateTime startDate = aYearBack.copyWith(day: aYearBack.day + start);
    DateTime endDate = (start >= totalDays - 7)
        ? today
        : aYearBack.copyWith(day: aYearBack.day + start + 7);
    int dayDifference = endDate.difference(startDate).inDays;

    listRows.add(Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
            dayDifference < 7 ? dayDifference + 1 : dayDifference,
            (index) => SingleDayTransaction(
                date: startDate.copyWith(day: startDate.day + index),
                transactions: const [])),
        if (dayDifference < 7)
          ...List.generate(
              7 - (dayDifference < 7 ? dayDifference + 1 : dayDifference),
              (index) => Container(
                    height: 20,
                    width: 20,
                    color: Colors.grey,
                    margin: const EdgeInsets.all(2),
                  )),
      ],
    ));
  }
  return listRows;
}

Widget firstWeekFill(int initialEmptyDays, DateTime startDate) {
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
              )),

      // rest days use increment to
      ...List.generate(
          7 - initialEmptyDays,
          (index) => SingleDayTransaction(
              date: startDate.copyWith(day: startDate.day + index),
              transactions: const [])),
    ],
  );
}
