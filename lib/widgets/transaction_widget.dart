import 'package:budget_planner/1_constants/2_helper.dart';
import 'package:budget_planner/1_constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../1_constants/1_models/transaction.dart';
import 'borrowing_transaction_widget.dart';
import 'expense_transaction_widget.dart';
import 'lending_transaction_widget.dart';
import 'saving_transaction_widget.dart';
import 'triple_rail.dart';

class TransactionWidget extends StatelessWidget {
  final DailyTransaction transaction;
  const TransactionWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    const double distance = 10;
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _BuildSummarySection(transaction: transaction, distance: distance),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transaction.microTransactions.length,
              itemBuilder: (_, i) {
                return _BuildMicroTransaction(
                  transaction: transaction.microTransactions[i],
                  distance: distance,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class _BuildSummarySection extends StatelessWidget {
  const _BuildSummarySection({
    required this.transaction,
    required this.distance,
  });

  final DailyTransaction transaction;
  final double distance;

  @override
  Widget build(BuildContext context) {
    return TripleRail(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            transaction.dateTime.day.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 40,
            ),
          ),
          SizedBox(width: distance),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEEE').format(
                  transaction.dateTime,
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                DateFormat('MMMM, yyyy').format(
                  transaction.dateTime,
                ),
                style: const TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
      trailing: Text(
        getAmountString(transaction.totalAmount),
        style: TextStyle(
          color: (transaction.totalAmount < 0) ? CTheme.expense : CTheme.imcome,
        ),
      ),
    );
  }
}

class _BuildMicroTransaction extends StatelessWidget {
  const _BuildMicroTransaction({
    required this.transaction,
    required this.distance,
  });

  final MicroTransaction transaction;
  final double distance;

  @override
  Widget build(BuildContext context) {
    if (transaction.type == "Income") {
      return Padding(
        padding: EdgeInsets.only(top: distance),
        child: SavingTransactionWIdget(
          transaction: transaction,
          distance: distance,
        ),
      );
    }
    if (transaction.subType == 'Lend') {
      return Padding(
        padding: EdgeInsets.only(top: distance),
        child: LendingTransactionWidget(
          transaction: transaction,
          distance: distance,
        ),
      );
    }
    if (transaction.subType == 'Borrow') {
      return Padding(
        padding: EdgeInsets.only(top: distance),
        child: BorrowingTransactionWidget(
          transaction: transaction,
          distance: distance,
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: distance),
      child: ExpenseTransactionWidget(
        transaction: transaction,
        distance: distance,
      ),
    );
  }
}
