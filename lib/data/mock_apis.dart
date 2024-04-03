import 'package:card_transactions/domain/transaction.dart';

List<Transaction> generatedTransactions = List.generate(
    20,
    (index) => Transaction(
        time: DateTime.now().copyWith(day: DateTime.now().day - index),
        amount: index * 2.0,
        id: "${DateTime.now().copyWith(day: index)}$index"));

class MockApi {
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
