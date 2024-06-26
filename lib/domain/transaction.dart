import 'package:card_transactions/utils.dart';

class Transaction {
  final DateTime time;
  final double amount;
  final String id;
  final String name;
  final TransactionType type;
  Transaction(
      {required this.time,
      required this.amount,
      required this.name,
      required this.id,
      required this.type});
}
