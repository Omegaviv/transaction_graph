import 'dart:math';

import 'package:card_transactions/domain/transaction.dart';

// Gemerating mock data
List<Transaction> generatedTransactions = List.generate(
    350,
    (index) => Transaction(
        time: DateTime.now().copyWith(day: DateTime.now().day - index),
        amount: Random().nextDouble() * 100 + 25,
        id: "${DateTime.now().copyWith(day: index)}$index"));

class MockApi {
  // Function to act a a api call, which will return list of transaction happed per day
  Future<Map<DateTime, List<Transaction>>> getTransactionByDateTime() async {
    Map<DateTime, List<Transaction>> data = {};

    for (var element in generatedTransactions) {
      final day =
          DateTime(element.time.year, element.time.month, element.time.day);
      if (data[day] == null) {
        data[day] = [element];
      } else {
        data[day]!.add(element);
      }
    }

    return data;
  }
}
