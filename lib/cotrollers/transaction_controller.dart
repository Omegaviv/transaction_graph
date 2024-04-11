import 'package:card_transactions/data/mock_apis.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  late MockApi _mockApi;
  Map<DateTime, List<Transaction>> transactions = {};
  var selectedDate = DateTime.now().obs;
  @override
  void onInit() {
    super.onInit();
    _mockApi = MockApi();
  }

  void updateSelecedDate(DateTime date) {
    selectedDate.value = date;
  }

  List<Transaction> getTransactionSelectedDate() {
    return transactions[selectedDate.value.copyWith(
            second: 0, minute: 0, microsecond: 0, millisecond: 0, hour: 0)] ??
        [];
  }

  double selectedDayTotal(List<Transaction> transaction) {
    double sum = 0;
    for (var element in transaction) {
      sum += element.amount;
    }
    return sum.toPrecision(2);
  }

  Future<Map<DateTime, List<Transaction>>> getTransactions() async {
    transactions = await _mockApi.getTransactionByDateTime();
    return transactions;
  }
}
