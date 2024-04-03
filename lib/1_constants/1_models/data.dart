import 'transaction.dart';

class Data {
  final String userName;
  int totalAmount;
  List<DailyTransaction> dailyTransactions = [];

  Data({
    required this.userName,
    this.totalAmount = 0,
    this.dailyTransactions = const <DailyTransaction>[],
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'totalAmount': totalAmount,
      'daily_transactions': dailyTransactions.map((t) => t.toJson()).toList(),
    };
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    // debugPrint('## transactions ${json['transactions'].runtimeType}');
    return Data(
      userName: json['userName'],
      totalAmount: json['totalAmount'] ?? 0,
      // transactions: [],
      dailyTransactions: json['daily_transactions'] != null
          ? (json['daily_transactions'] as List)
              .map((item) => DailyTransaction.fromJson(item))
              .toList()
          : const <DailyTransaction>[],
    );
  }

  // @override
  // String toString() {
  //   return 'Data(userName: $userName, userEmail: $userEmail, userPhone: $userPhone, totalAmount: $totalAmount)';
  // }

  // List<Transaction> transactionFromJson(dynamic jsonData) {
  //   if(jsonData.isEmpty)
  //   return [];
  // }
}


 // factory Data.fromJson(Map<String, dynamic> data) {
  //   return Data(
  //     userName: data['userName'],
  //     userEmail: data['userEmail'],
  //     userPhone: data['userPhone'],
  //     totalAmount: data['totalAmount'] ?? 0,
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'userName': userName,
  //     'userEmail': userEmail,
  //     'userPhone': userPhone,
  //     'totalAmount': totalAmount,
  //   };
  // }