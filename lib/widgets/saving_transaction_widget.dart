import 'package:flutter/material.dart';
import '../1_constants/1_models/transaction.dart';
import '../1_constants/2_helper.dart';
import '../1_constants/theme.dart';
import 'triple_rail.dart';

class SavingTransactionWIdget extends StatelessWidget {
  const SavingTransactionWIdget({
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
          CircleAvatar(
            radius: 27,
            child: Image.asset(
              transaction.subTypeImg,
              height: 25,
            ),
          ),
          SizedBox(width: distance),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capitalize(transaction.type),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                capitalize(transaction.subType),
                style: const TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
      // trailing: Text(
      //   'Tk ${transaction.amount}.00',
      //   style: TextStyle(color: CTheme.imcome),
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

// class _BuildIcon extends StatelessWidget {
//   final TransactionType transactionType;
//   const _BuildIcon({required this.transactionType});

//   @override
//   Widget build(BuildContext context) {
//     if (transactionType == TransactionType.saving) {
//       return CircleAvatar(
//         radius: 27,
//         child: Image.asset(
//           'assets/components/saving_icon.png',
//           height: 25,
//         ),
//       );
//     }
//     return CircleAvatar(
//       radius: 27,
//       child: Text(transactionType.name.substring(0, 1)),
//     );
//   }
// }
