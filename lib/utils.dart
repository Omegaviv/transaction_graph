import 'package:card_transactions/constants.dart';

enum WeekLableVisiblityType { none, oddDays, evenDays, all }

enum MonthLabelVisiblityType { none, short, full }

enum TransactionType { credit, debit }

class DateFormaters {
  static String to12Hrs(DateTime dt) {
    int hour = dt.hour;
    int minute = dt.minute;
    String period = (hour < 12) ? 'AM' : 'PM';
    if (hour > 12) {
      hour -= 12;
    }
    String formattedTime = '$hour:${minute.toString().padLeft(2, '0')} $period';
    return formattedTime;
  }

  static String toDDMMMYYYY(DateTime date) {
    return '${date.day} ${Constants.SHORT_MONTH_LABEL[date.month - 1]} ${date.year}';
  }

  static DateTime toDDMMMYYYYObject(DateTime date) {
    return date.copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  }
}
