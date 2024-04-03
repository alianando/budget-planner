import 'package:flutter/material.dart';

import '../1_constants/1_models/transaction.dart';
import '../1_constants/2_helper.dart';
import '../1_constants/theme.dart';
import 'triple_rail.dart';

class BorrowingTransactionWidget extends StatelessWidget {
  const BorrowingTransactionWidget({
    required this.transaction,
    required this.distance,
    super.key,
  });

  final MicroTransaction transaction;
  final double distance;

  @override
  Widget build(BuildContext context) {
    return TripleRail(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 27, child: Text('You')),
          SizedBox(width: distance * 2),
          const Center(child: Icon(Icons.arrow_back)),
          SizedBox(width: distance * 2),
          CircleAvatar(
            radius: 27,
            child: Text(
              transaction.otherPerson.substring(0, 2).toUpperCase(),
            ),
          ),
        ],
      ),
      // trailing: Text(
      //   'Tk ${transaction.amount}.00',
      //   style: TextStyle(color: CTheme.expense),
      // ),
      trailing: Text(
        getAmountString(transaction.amount),
        style: TextStyle(
          color: (transaction.amount < 0) ? CTheme.expense : CTheme.imcome,
        ),
      ),
    );
  }
}
