import 'package:budget_planner/1_constants/1_models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:unique_simple_bar_chart/data_models.dart';
import 'package:unique_simple_bar_chart/simple_bar_chart.dart';

import '../1_constants/1_models/data.dart';

class ReportsPage extends StatefulWidget {
  final Data data;
  const ReportsPage({super.key, required this.data});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<HorizontalDetailsModel> listOfHorizontalBarData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text('Last 7 days'),
            BuildBarchart(data: widget.data),
          ],
        ),
      ),
    );
  }
}

class BuildBarchart extends StatefulWidget {
  final Data data;
  const BuildBarchart({super.key, required this.data});

  @override
  State<BuildBarchart> createState() => _BuildBarchartState();
}

class _BuildBarchartState extends State<BuildBarchart> {
  List<HorizontalDetailsModel> listOfHorizontalBarData = [];

  @override
  void initState() {
    _buildBardata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listOfHorizontalBarData.isEmpty) {
      return const SizedBox(height: 250, child: Center(child: Text('No data')));
    }
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SimpleBarChart(
          makeItDouble: true,
          listOfHorizontalBarData: listOfHorizontalBarData,
          verticalInterval: 30.33,
          fullBarChartHeight: 250,
          horizontalBarPadding: 15,
        ),
      ),
    );
  }

  _buildBardata() {
    List<HorizontalDetailsModel> tempList = [];
    List<DailyTransaction> transactions = widget.data.dailyTransactions;
    int maxAmount = 0;
    for (var t in transactions) {
      if (t.totalAmount.abs() > maxAmount) {
        maxAmount = t.totalAmount.abs();
      }
    }
    if (transactions.length >= 2) {
      transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    }
    int limit = (transactions.length >= 7) ? 7 : transactions.length;
    for (int i = 0; i < limit; i++) {
      var transaction = transactions[i];

      double val =
          ((transaction.totalAmount.abs() / maxAmount) * 100).toDouble();
      tempList.add(
        HorizontalDetailsModel(
          name:
              '${transaction.dateTime.day}/${transaction.dateTime.month}/${transaction.dateTime.year}',
          color: (transaction.totalAmount < 0) ? Colors.red : Colors.blue,
          size: val,
          // sizeTwo: 40,
          // colorTwo: Colors.blue,
        ),
      );
    }
    // tempList = [
    //   HorizontalDetailsModel(
    //     name: 'Mon',
    //     color: const Color(0xFFEB7735),
    //     size: 73,
    //     sizeTwo: 40,
    //     colorTwo: Colors.blue,
    //   ),
    //   HorizontalDetailsModel(
    //     name: 'Tues',
    //     color: const Color(0xFFEB7735),
    //     size: 92,
    //     sizeTwo: 85,
    //     colorTwo: Colors.blue,
    //   ),
    //   HorizontalDetailsModel(
    //     name: 'Wed',
    //     color: const Color(0xFFFBBC05),
    //     size: 120,
    //     sizeTwo: 100,
    //     colorTwo: Colors.blue,
    //   ),
    //   HorizontalDetailsModel(
    //     name: 'Thurs',
    //     color: const Color(0xFFFBBC05),
    //     size: 86,
    //     sizeTwo: 220,
    //     colorTwo: Colors.blue,
    //   ),
    //   HorizontalDetailsModel(
    //     name: 'Fri',
    //     color: const Color(0xFFFBBC05),
    //     size: 64,
    //     sizeTwo: 170,
    //     colorTwo: Colors.blue,
    //   ),
    //   HorizontalDetailsModel(
    //     name: 'Sat',
    //     color: const Color(0xFFFBBC05),
    //     size: 155,
    //     sizeTwo: 120,
    //     colorTwo: Colors.blue,
    //   ),
    //   HorizontalDetailsModel(
    //     name: 'Sun',
    //     color: const Color(0xFFFBBC05),
    //     size: 200,
    //     sizeTwo: 96,
    //     colorTwo: Colors.blue,
    //   ),
    // ];
    if (mounted) {
      setState(() {
        listOfHorizontalBarData = tempList;
      });
    }
  }
}
