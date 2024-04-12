import 'package:card_transactions/constants.dart';
import 'package:card_transactions/data/mock_apis.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/presentation/home_page.dart';
import 'package:card_transactions/presentation/transaction_page.dart';
import 'package:card_transactions/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class TestMockApi extends Mock implements MockApi {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TestMockApi mockApi;

  setUp(() {
    Get.testMode = true;
    mockApi = TestMockApi();
  });

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

  Widget baseTestApp() {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Constants.BRAND_COLOR),
        useMaterial3: true,
      ),
      home: HomePage(
        repository: mockApi,
      ),
    );
  }

  Widget testAppTransactionPage() {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Constants.BRAND_COLOR),
        useMaterial3: true,
      ),
      home: Transactionpage(
        transactions: listTransactions,
        date: DateTime(2024, 1, 12),
        totalAmount: 200,
      ),
    );
  }

  testWidgets("Transaction graph widget found", (widgetTester) async {
    when(() => mockApi.getTransactionByDateTime())
        .thenAnswer((_) async => transactionsByDateTime);

    await widgetTester.pumpWidget(baseTestApp());
    await widgetTester.pump();
    expect(find.byKey(const Key('graph-widget')), findsOneWidget);
  });

  testWidgets("All transaction heat of last year displyed",
      (widgetTester) async {
    when(() => mockApi.getTransactionByDateTime())
        .thenAnswer((_) async => transactionsByDateTime);

    await widgetTester.pumpWidget(baseTestApp());
    await widgetTester.pump();
    DateTime today = DateTime.now();
    DateTime aYearBack = today.copyWith(year: today.year - 1);
    int totalDays = today.difference(aYearBack).inDays;

    for (int i = 0; i <= totalDays; i++) {
      expect(
          find.byKey(Key(DateFormaters.toDDMMMYYYYObject(
                  aYearBack.copyWith(day: aYearBack.day + i))
              .toString())),
          findsOneWidget);
    }
  });

  testWidgets("Month and Week labels displayed", (widgetTester) async {
    when(() => mockApi.getTransactionByDateTime())
        .thenAnswer((_) async => transactionsByDateTime);

    await widgetTester.pumpWidget(baseTestApp());
    await widgetTester.pump();

    for (var month in Constants.SHORT_MONTH_LABEL) {
      expect(find.text(month), findsOne);
    }

    for (var week in Constants.WEEK_LABEL) {
      expect(find.text(week), findsOne);
    }
  });

  testWidgets("Transactiop page", (widgetTester) async {
    await widgetTester.pumpWidget(testAppTransactionPage());
    await widgetTester.pump();

    expect(find.text('Transactions'), findsOneWidget);

    for (var transaction in listTransactions) {
      expect(find.byKey(Key(transaction.id)), findsOneWidget);
    }
  });
}
