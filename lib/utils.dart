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
}
