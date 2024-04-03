// ignore_for_file: file_names

import 'package:budget_planner/1_constants/2_helper.dart';
import 'package:flutter/material.dart';

import '../../1_constants/1_models/data.dart';
import '../../1_constants/1_models/transaction.dart';
import '../../1_constants/theme.dart';
import '../../widgets/triple_rail.dart';

class MonthSummary extends StatefulWidget {
  final Data data;
  const MonthSummary({super.key, required this.data});

  @override
  State<MonthSummary> createState() => _MonthSummaryState();
}

class _MonthSummaryState extends State<MonthSummary> {
  double income = 0;
  double expense = 0;
  double total = 0;

  @override
  void initState() {
    super.initState();
    final DateTime today = DateTime.now();
    final int year = today.year;
    final int month = today.month;
    List<DailyTransaction> dailyTrnList = [];
    List<DailyTransaction> targetDailyTrnList = [];
    dailyTrnList = widget.data.dailyTransactions;
    for (int i = 0; i < dailyTrnList.length; i++) {
      DailyTransaction dailyTrn = dailyTrnList[i];
      if (dailyTrn.dateTime.month == month) {
        if (dailyTrn.dateTime.year == year) {
          targetDailyTrnList.add(dailyTrn);
        }
      }
    }
    if (targetDailyTrnList.isNotEmpty) {
      for (DailyTransaction dt in targetDailyTrnList) {
        for (MicroTransaction mt in dt.microTransactions) {
          // int constant = getConstant(mt.type, mt.subType); // 1 or -1.
          if (mt.amount < 0) {
            expense = expense - mt.amount;
          }
          if (mt.amount > 0) {
            income = income + mt.amount;
          }
        }
      }
    }
    total = income + expense;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// title
          Padding(
            padding: const EdgeInsets.only(left: 45, right: 45, bottom: 8),
            child: TripleRail(
              leading: Icon(
                Icons.arrow_back_ios,
                color: CTheme.primaryColor,
                size: 16,
              ),
              middle: Text(
                'This Month',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CTheme.primaryColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: CTheme.primaryColor,
                size: 16,
              ),
            ),
          ),

          /// card
          Card(
            elevation: 1,
            color: Colors.white,
            // clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TripleRail(
                    leading: const Text('Income'),
                    trailing: Text(
                      'Tk $income',
                      style: TextStyle(
                        color: CTheme.primaryColor,
                      ),
                    ),
                  ),
                  TripleRail(
                    leading: const Text('Expense'),
                    trailing: Text(
                      'TK $expense',
                      style: TextStyle(
                        color: CTheme.expense,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black12,
                    thickness: 0.7,
                  ),
                  // TripleRail(
                  //   leading: const Text('Total'),
                  //   trailing: Text(
                  //     'TK $total',
                  //   ),
                  // )
                  TripleRail(
                    leading: const Text('Total'),
                    trailing: Text(
                      getAmountString(total.toInt()),
                      style: TextStyle(
                        color: (total < 0) ? CTheme.expense : CTheme.imcome,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
