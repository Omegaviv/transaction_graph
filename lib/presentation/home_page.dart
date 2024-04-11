import 'package:card_transactions/cotrollers/transaction_controller.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/presentation/widgets/transaction_graph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.put(TransactionController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Card(
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 20),

                    // Dummy function to create mock data
                    child: FutureBuilder<Map<DateTime, List<Transaction>>>(
                        future: transactionController.getTransactions(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError ||
                              snapshot.data == null) {
                            return const Text("Someting went wrong");
                          }
                          return TransactionGraph(
                            transactionData: snapshot.data ?? {},
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
