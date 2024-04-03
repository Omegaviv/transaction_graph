import 'dart:math';

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
    List<Transaction> generatedTransactions = List.generate(
      365,
      (index) => Transaction(
          time: DateTime.now().copyWith(day: DateTime.now().day - index),
          amount: Random().nextDouble() * 100 + 25,
          id: "${DateTime.now().copyWith(day: index)}$index",
          type: Random().nextInt(10).isEven
              ? TransactionType.credit
              : TransactionType.debit),
    );
    return generatedTransactions;
  }
}
