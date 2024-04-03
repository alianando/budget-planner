// ignore_for_file: file_names
import '1_models/data.dart';

String? validatePasswordString(String? val) {
  if (val == null) {
    return 'Password can not be empty';
  } else if (val.isEmpty) {
    return 'Password can not be empty';
  }
  bool containNumber = false;
  for (int i = 0; i < 10; i++) {
    if (val.contains('$i')) {
      containNumber = true;
      break;
    }
  }
  if (!containNumber) {
    return 'Password must contain a number';
  }

  bool containsCharacter = false;
  for (int i = 0; i < symbol.length; i++) {
    if (val.contains(symbol[i])) {
      containsCharacter = true;
      break;
    }
  }
  if (!containsCharacter) {
    return 'Password must contain alteast one symbol';
  }

  bool containsUpperCaseLatter = false;
  for (int i = 0; i < latters.length; i++) {
    if (val.contains(latters[i].toUpperCase())) {
      containsUpperCaseLatter = true;
      break;
    }
  }
  if (!containsUpperCaseLatter) {
    return 'Password must contain alteast 1 uppercase alphabate';
  }

  bool containsLowerCaseLatter = false;
  for (int i = 0; i < latters.length; i++) {
    if (val.contains(latters[i])) {
      containsLowerCaseLatter = true;
      break;
    }
  }
  if (!containsLowerCaseLatter) {
    return 'Password must contain alteast 1 lowercase alphabate';
  }

  if (val.length < 6 || val.length > 15) {
    return 'password length must be of 6-15 characters';
  }

  return null;
}

List<String> symbol = [
  '!',
  '@',
  '#',
  "%",
  '^',
  '&',
  '*',
  "(",
  ')',
  '_',
  '-',
  '+',
  '=',
  '?',
  '/',
  '{',
  '}'
];

List<String> latters = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z",
];

String capitalize(String val) {
  return "${val[0].toUpperCase()}${val.substring(1).toLowerCase()}";
}

// Data calculateAmounts(Data oldD) {
//   double totalAmount = 0;
//   double dailyAmount = 0;
//   for (int i = 0; i < oldD.transactions.length; i++) {
//     dailyAmount = 0;
//     DailyTransaction dt = oldD.transactions[i];
//     for (int j = 0; j < dt.transactions.length; j++) {
//       MicroTransaction mt = dt.transactions[j];
//     }
//   }
//   return oldD;
// }

// Data adjustAmount(
//   Data oldD,
//   double amount,
//   String tType,
//   String tSubType,
//   int dailyTIndex,
// ) {
//   int constant = getConstant(tType, tSubType); // 1 or -1
//   double na = amount * constant.toDouble();
//   debugPrint('## na : $na');

//   debugPrint('## old_dm ${oldD.dailyTransactions[dailyTIndex].totalAmount}');
//   double dm = na + oldD.dailyTransactions[dailyTIndex].totalAmount;
//   debugPrint('## new_dm $dm');
//   oldD.dailyTransactions[dailyTIndex].totalAmount = dm;

//   /// update total Amount.
//   int oldTotalAmount = oldD.totalAmount;
//   int addedTotalAmount = amount.toInt() * constant;
//   oldD.totalAmount = oldTotalAmount + addedTotalAmount;
//   debugPrint(
//     '## total_amount : old $oldTotalAmount, added $addedTotalAmount, result ${oldD.totalAmount}',
//   );

//   return oldD;
// }

Data updateAmount(
  Data oldD,
  int amount,
  int dailyTIndex,
) {
  oldD.totalAmount += amount;
  oldD.dailyTransactions[dailyTIndex].totalAmount += amount;
  return oldD;
}

int getConstant(String tType, String tSubType) {
  if (tType == 'Expense') {
    return -1;
  } else if (tSubType == 'Lend') {
    return -1;
  } else if (tSubType == 'Repayment') {
    return -1;
  } else if (tSubType == 'Debt Collection') {
    return -1;
  }
  return 1;
}

String getAmountString(int val) {
  if (val < 0) {
    val = val * (-1);
  }
  return 'TK $val.00';
}
