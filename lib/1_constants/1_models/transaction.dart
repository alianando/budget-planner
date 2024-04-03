class DailyTransaction {
  DateTime dateTime;
  int totalAmount;
  List<MicroTransaction> microTransactions;

  DailyTransaction({
    required this.dateTime,
    this.totalAmount = 0,
    this.microTransactions = const <MicroTransaction>[],
  });

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'totalAmount': totalAmount,
      'micro_transactions': microTransactions.map((tx) => tx.toJson()).toList(),
    };
  }

  factory DailyTransaction.fromJson(Map<String, dynamic> json) {
    var transactionsList = json['micro_transactions'] as List;
    List<MicroTransaction> transactions = transactionsList
        .map((txJson) => MicroTransaction.fromJson(txJson))
        .toList();

    return DailyTransaction(
      dateTime: DateTime.parse(json['dateTime']),
      totalAmount: json['totalAmount'],
      microTransactions: transactions,
    );
  }
}

class MicroTransaction {
  String type;
  String subType;
  String subTypeImg;
  int amount;
  DateTime time;
  String note;
  String otherPerson;

  MicroTransaction({
    required this.type,
    required this.subType,
    required this.subTypeImg,
    required this.amount,
    required this.time,
    this.note = '',
    this.otherPerson = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'subType': subType,
      'subTypeImg': subTypeImg,
      'amount': amount,
      'time': time.toIso8601String(),
      'note': note,
      'otherPerson': otherPerson,
    };
  }

  factory MicroTransaction.fromJson(Map<String, dynamic> json) {
    return MicroTransaction(
      type: json['type'],
      subType: json['subType'],
      subTypeImg: json['subTypeImg'],
      amount: json['amount'],
      time: DateTime.parse(json['time']),
      note: json['note'] ?? '',
      otherPerson: json['otherPerson'] ?? '',
    );
  }
}
