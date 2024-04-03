import 'package:card_transactions/data/mock_apis.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/presentation/widgets/transaction_graph.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final mockApi = MockApi();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Card(
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
              child: FutureBuilder<Map<DateTime, List<Transaction>>>(
                  future: mockApi.getTransactionByDateTime(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return const Text("Someting went wrong");
                    }
                    return TransactionGraph(
                      transactionData: snapshot.data ?? {},
                      onPressDay: (transactions, day) {
                        print("the day clicked in $day");
                        print(
                            "total transaction that day is ${transactions.length}");
                      },
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
