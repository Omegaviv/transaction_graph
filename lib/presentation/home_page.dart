import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime aYearBack = today.copyWith(year: today.year - 1);
    int totalDays = today.difference(aYearBack).inDays;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Row(
          children: [
            for (int i = 0; i <= totalDays; i += 7)
              Column(
                children: [],
              )
          ],
        )),
      ),
    );
  }
}

List<Widget> function() {
  List<Widget> listRows = [];
  DateTime today = DateTime.now();
  DateTime aYearBack = today.copyWith(year: today.year - 1);
  int totalDays = today.difference(aYearBack).inDays;

  int firstDay = aYearBack.weekday;
  int startOfCal = 0;
  if (firstDay != 7) {
    startOfCal = 7 - firstDay;

    listRows.add(firstWeekFill(firstDay, today));
  }

  for (int start = startOfCal; start <= totalDays; start += 7) {
    DateTime startDate = aYearBack.copyWith(day: today.day + start);
    DateTime endDate = aYearBack.copyWith(day: today.day + start + 6);

    // widgets of normat week

    // empty container when all days are covered
  }
  return listRows;
}

Widget firstWeekFill(int initialEmptyDays, DateTime startDate) {
  return Column(
    children: [
      ...List.generate(
          initialEmptyDays,
          (index) => Container(
                height: 10,
                width: 10,
                color: Colors.green,
              )),

      // rest days use increment to
      ...List.generate(
          7 - initialEmptyDays,
          (index) => Container(
                height: 10,
                width: 10,
                color: Colors.green,
              )),
    ],
  );
}
