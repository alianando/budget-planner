import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../1_constants/1_models/data.dart';
import '1_app_bar/1_app_bar.dart';
import '2_month_summary/1_month_summary.dart';
import '3_transactions/all_transaction.dart';

class HomePage extends StatelessWidget {
  final Data data;
  // final User user;
  const HomePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, 150),
        child: CustomAppBar(user: user, totalAmount: data.totalAmount),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            MonthSummary(data: data),
            const SizedBox(height: 10),
            AllTransactions(data: data),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
