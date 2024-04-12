import 'package:card_transactions/data/mock_apis.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:card_transactions/cotrollers/transaction_controller.dart';

class TestMockApi extends Mock implements MockApi {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TransactionController transactionController;
  late TestMockApi mockApi;

  final List<Transaction> listTransactions = [
    Transaction(
        time: DateTime(2024, 1, 12),
        amount: 100,
        name: "test 1",
        id: "id1",
        type: TransactionType.credit),
    Transaction(
        time: DateTime(2024, 1, 12),
        amount: 100,
        name: "test 3",
        id: "id3",
        type: TransactionType.credit)
  ];

  final Map<DateTime, List<Transaction>> transactionsByDateTime = {
    DateTime(2024, 1, 12): listTransactions,
  };

  setUp(() {
    Get.testMode = true;
    mockApi = TestMockApi();
    transactionController = TransactionController(mockApi: mockApi);
    Get.put<TransactionController>(transactionController);
  });

  test('Inital value of controller', () {
    expect(
        transactionController.selectedDate.value
            .copyWith(second: 0, microsecond: 0, millisecond: 0),
        DateTime.now().copyWith(second: 0, microsecond: 0, millisecond: 0));
    expect(transactionController.transactions, {});
  });

  test('Update selcted date', () {
    final date = DateTime.now();
    transactionController.updateSelecedDate(date);
    expect(transactionController.selectedDate.value, date);
  });

  test('Get Transaction function call by date time, transaction by Date',
      () async {
    when(() => mockApi.getTransactionByDateTime())
        .thenAnswer((_) async => transactionsByDateTime);

    await transactionController.getTransactions();
    expect(transactionController.transactions, transactionsByDateTime);
    transactionController.updateSelecedDate(DateTime(2024, 1, 12));
    expect(
        transactionController.getTransactionSelectedDate(), listTransactions);
  });

  test('Selected day total amount', () {
    expect(transactionController.selectedDayTotal(listTransactions), 200.0);
  });
}
