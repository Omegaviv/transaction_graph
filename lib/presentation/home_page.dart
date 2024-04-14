import 'package:card_transactions/constants.dart';
import 'package:card_transactions/cotrollers/transaction_controller.dart';
import 'package:card_transactions/data/mock_apis.dart';
import 'package:card_transactions/domain/transaction.dart';
import 'package:card_transactions/presentation/widgets/custom_animation.dart';
import 'package:card_transactions/presentation/widgets/transaction_graph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.repository});

  final MockApi repository;
  @override
  Widget build(BuildContext context) {
    final transactionController =
        Get.put(TransactionController(mockApi: repository));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Your Card',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: CreditCardPreviewAnimation(),
                ),
                Row(
                  children: [
                    const Text(
                      'Year History',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    const Spacer(),
                    const Text('Horizontal/Vertical'),
                    const SizedBox(
                      width: 20,
                    ),
                    Obx(() => Switch(
                          value: transactionController.verticleView.value,
                          onChanged: (bool value) {
                            transactionController.updateViewAxis(value);
                          },
                        )),
                  ],
                ),
                Card(
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
                          return GetBuilder<TransactionController>(
                            builder: (controller) {
                              return TransactionGraph(
                                transactionData: snapshot.data ?? {},
                                key: const Key(Constants.GRAPH_Widget),
                                verticleView: controller.verticleView.value,
                                size: 20,
                              );
                            },
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
