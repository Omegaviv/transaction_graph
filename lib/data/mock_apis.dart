import 'dart:math';

import 'package:card_transactions/constants.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/utils.dart';

class MockApi {
  // Function to act a a api call, which will return list of transaction happed per day
  Future<Map<DateTime, List<Transaction>>> getTransactionByDateTime() async {
    Map<DateTime, List<Transaction>> data = {};
    List<Transaction> transactions = generateTransactions();
    for (var element in transactions) {
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

  // Gemerating mock data
  List<Transaction> generateTransactions() {
    List<Transaction> generatedTransactions = [];

    for (int i = 0; i <= 365; i++) {
      int perDayTransaction = Random().nextInt(10);
      for (int j = 0; j < perDayTransaction; j++) {
        generatedTransactions.add(Transaction(
            time: DateTime.now().copyWith(day: DateTime.now().day - i),
            amount: Random().nextDouble() * 100 + 25,
            id: "${DateTime.now().copyWith(day: i)}$i$j",
            name: Constants.DUMMY_NAMES[j % Constants.DUMMY_NAMES.length],
            type: Random().nextInt(10).isEven
                ? TransactionType.credit
                : TransactionType.debit));
      }
    }
    return generatedTransactions;
  }
}
