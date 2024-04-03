// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../1_constants/1_models/data.dart';
import '../widgets/triple_rail.dart';
import '2_add_expense_page/1_add_expense_page.dart';
import '3_add_income_page/add_income_page.dart';
import '4_add_debt_page/add_debt_page.dart';

class AddTransactionPage extends StatefulWidget {
  final Data data;
  const AddTransactionPage({super.key, required this.data});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  int _currentIndex = 0;

  void updateActive(int newId) {
    setState(() {
      _currentIndex = newId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 0, 0, 0)
                          .withOpacity(.3), // Shadow color
                      spreadRadius: 1, // Spread radius
                      blurRadius: 3, // Blur radius
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 320,
                    child: TripleRail(
                      leading: BuildTransactionTypeButton(
                        title: 'Expense',
                        activeInd: _currentIndex,
                        ownInd: 0,
                        ontap: updateActive,
                      ),
                      middle: BuildTransactionTypeButton(
                        title: 'Income',
                        activeInd: _currentIndex,
                        ownInd: 1,
                        ontap: updateActive,
                      ),
                      trailing: BuildTransactionTypeButton(
                        title: 'Debt',
                        activeInd: _currentIndex,
                        ownInd: 2,
                        ontap: updateActive,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            if (_currentIndex == 0) BuildExpenseEditor(data: widget.data),
            if (_currentIndex == 1) BuildIncomeEditor(data: widget.data),
            if (_currentIndex == 2) BuildDebtSubtype(data: widget.data),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class BuildTransactionTypeButton extends StatelessWidget {
  final String title;
  final int activeInd;
  final int ownInd;
  final Function(int id) ontap;
  const BuildTransactionTypeButton({
    super.key,
    required this.title,
    required this.activeInd,
    required this.ownInd,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = ownInd == activeInd;
    return InkWell(
      onTap: () => ontap(ownInd),
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : const Color.fromARGB(255, 0, 0, 0),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        height: 35,
        width: 100,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
