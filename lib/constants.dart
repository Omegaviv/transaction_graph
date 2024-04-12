import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static const List<String> WEEK_LABEL = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  static const List<String> SHORT_MONTH_LABEL = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> MONTH_LABEL = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const DUMMY_NAMES = [
    "Adidas",
    "Vivek Verma",
    "Starbucks",
    "Dropboc",
    "AirBnb",
    "Luffy"
  ];

  static Color NO_TRANSACTION_COLOR = Colors.white.withOpacity(0.6);
  static Color BRAND_COLOR = const Color(0xFFcb5019);

  // keys

  static const String FULL_DISPLAY_DATE = 'displayed-ful-date';
  static const String TOTAL_AMOUNT = 'total-amount';
  static const String GRAPH_Widget = 'graph-widget';
}
