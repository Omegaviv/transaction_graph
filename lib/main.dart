import 'package:card_transactions/constants.dart';
import 'package:card_transactions/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Constants.BRAND_COLOR),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
