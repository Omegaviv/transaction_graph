import 'package:card_transactions/constants.dart';
import 'package:card_transactions/utils.dart';
import 'package:flutter/material.dart';

class WeekLabel extends StatelessWidget {
  const WeekLabel(
      {super.key,
      required this.weekLableVisiblityType,
      required this.fontSize,
      required this.size,
      required this.verticalView,
      required this.margin});
  final WeekLableVisiblityType weekLableVisiblityType;
  final double fontSize;
  final double size;
  final double margin;
  final bool verticalView;

  @override
  Widget build(BuildContext context) {
    if (weekLableVisiblityType == WeekLableVisiblityType.none) {
      return Container();
    }

    if (verticalView)
      return _buildVerticleView();
    else
      return _buildHorizontelView();
  }

  Widget _buildVerticleView() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: Constants.WEEK_LABEL
          .asMap()
          .entries
          .map((day) => _renderWeekLabel(day.key, day.value))
          .toList(),
    );
  }

  Widget _buildHorizontelView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: Constants.WEEK_LABEL
          .asMap()
          .entries
          .map((day) => _renderWeekLabel(day.key, day.value))
          .toList(),
    );
  }

  Widget _renderWeekLabel(int index, String day) {
    if (weekLableVisiblityType == WeekLableVisiblityType.all) {
      return DayLabel(
        day: day,
        size: size,
      );
    } else if (weekLableVisiblityType == WeekLableVisiblityType.evenDays) {
      if (index.isOdd) {
        return DayLabel(
          day: day,
          size: size,
        );
      }
    } else {
      if (index.isEven) {
        return DayLabel(
          day: day,
          size: size,
        );
      }
    }

    return Container(
      height: size,
      margin: EdgeInsets.all(margin),
    );
  }
}

class DayLabel extends StatelessWidget {
  const DayLabel(
      {super.key,
      this.fontSize = 12,
      this.size = 20,
      this.margin = 2,
      required this.day});
  final double fontSize;
  final double size;
  final double margin;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      margin: EdgeInsets.all(margin),
      child: Center(
        child: Text(
          day,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}
