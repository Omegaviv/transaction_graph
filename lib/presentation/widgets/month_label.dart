import 'package:card_transactions/constants.dart';
import 'package:card_transactions/utils.dart';
import 'package:flutter/material.dart';

class MonthLabel extends StatelessWidget {
  const MonthLabel(
      {super.key,
      required this.startDate,
      required this.monthLabelVisiblityType,
      required this.size,
      required this.fontSize,
      required this.verticalView});
  final DateTime startDate;
  final MonthLabelVisiblityType monthLabelVisiblityType;
  final double fontSize;
  final double size;
  final bool verticalView;

  @override
  Widget build(BuildContext context) {
    if (monthLabelVisiblityType == MonthLabelVisiblityType.none) {
      return Container();
    }
    List<String> labels =
        monthLabelVisiblityType == MonthLabelVisiblityType.short
            ? Constants.SHORT_MONTH_LABEL
            : Constants.MONTH_LABEL;
    if (verticalView) {
      return _buildVerticleView(labels);
    } else {
      return _buildHorizontalView(labels);
    }
  }

  Widget _buildVerticleView(List<String> labels) {
    return Padding(
      padding: EdgeInsets.only(top: size),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: labels
            .asMap()
            // using asMap and Entreis to get index and value at the same time
            .entries
            .map(
              (e) => SizedBox(
                height: size * 5,
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    labels[(e.key + (startDate).month - 1) % 12],
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildHorizontalView(List<String> labels) {
    return Padding(
      padding: EdgeInsets.only(left: size),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: labels
            .asMap()
            // using asMap and Entreis to get index and value at the same time
            .entries
            .map(
              (e) => SizedBox(
                width: size * 5,
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
