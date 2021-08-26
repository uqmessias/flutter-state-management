import 'package:intl/intl.dart';

class TransferTransaction {
  final int id;
  final String account;
  final DateTime date;
  final String description;
  final double amount;
  final bool confirmed;

  TransferTransaction({
    required this.id,
    required this.account,
    required this.date,
    required this.description,
    required this.amount,
    required this.confirmed,
  });

  factory TransferTransaction.getFromJson(Map<String, dynamic> json) {
    return TransferTransaction(
      id: json['id'],
      account: json['account'],
      date: DateFormat('d/M/y').parse(json['date']),
      description: json['description'],
      amount: json['amount'],
      confirmed: json['confirmed'],
    );
  }
}

class Transaction extends TransferTransaction {
  final String category;

  Transaction({
    required int id,
    required String account,
    required this.category,
    required DateTime date,
    required String description,
    required double amount,
    required bool confirmed,
  }) : super(
          id: id,
          account: account,
          date: date,
          description: description,
          amount: amount,
          confirmed: confirmed,
        );

  factory Transaction.getFromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      account: json['account'],
      category: json['category'],
      date: DateFormat('d/M/y').parse(json['date']),
      description: json['description'],
      amount: json['amount'],
      confirmed: json['confirmed'],
    );
  }
}
