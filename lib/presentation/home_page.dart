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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Card(
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
              child: TransactionGraph(
                transactionData: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
