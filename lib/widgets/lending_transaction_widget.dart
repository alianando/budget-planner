import 'package:flutter/material.dart';

import '../1_constants/1_models/transaction.dart';
import '../1_constants/2_helper.dart';
import '../1_constants/theme.dart';
import 'triple_rail.dart';

class LendingTransactionWidget extends StatelessWidget {
  const LendingTransactionWidget({
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
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.yellow,
              border: Border.all(color: Colors.blueAccent),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: const Center(child: Text('You')),
          ),
          SizedBox(width: distance * 2),
          const Center(child: Icon(Icons.arrow_forward)),
          SizedBox(width: distance * 2),
          CircleAvatar(
            radius: 27,
            child: Text(getImgName(transaction.otherPerson)),
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

  String getImgName(String value) {
    if (value.length < 3) {
      return value;
    }
    return transaction.otherPerson.substring(0, 3).toUpperCase();
  }
}
