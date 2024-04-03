import 'package:budget_planner/8_root/root_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../12_add_page/1_add_transaction_page.dart';
import '../13_report_page.dart/report_page.dart';
import '../14_more/more_page.dart';
import '../1_constants/1_models/data.dart';
import '../9_home_page/home_page.dart';

class Root extends StatefulWidget {
  final Data data;
  const Root({super.key, required this.data});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  // int _currentIndex = 2;

  Widget _buildBody(Data data, int index) {
    if (index == 0) {
      return HomePage(data: widget.data);
    }
    if (index == 2) {
      return AddTransactionPage(data: data);
    }
    if (index == 3) {
      return ReportsPage(data: data);
    }
    if (index == 4) {
      return MorePage(data: data);
    }
    return Center(child: Text('$index'));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RootProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: _buildBody(widget.data, provider.rootIndex),
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.rootIndex,
          onTap: (index) => provider.updateRootIndex(index),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              label: 'Budget',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq),
              label: 'Reports',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
          ],
        ),
      );
    });
  }
}
