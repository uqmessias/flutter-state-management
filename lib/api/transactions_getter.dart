import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/transaction.dart';

class TransactionsGetter {
  static const String URL =
      'https://gist.githubusercontent.com/uqmessias/f5419f1905ae2991a17b3699d7861f1d/raw/4b49a35a593609a460f8bcc3fe58f14bb832df53/finances-data.json';
  static Future<List<TransferTransaction>> getTransactions() async {
    final response = await http.get(Uri.parse(URL));

    if (response.statusCode < 400 && response.statusCode >= 200) {
      final transactionObject = jsonDecode(response.body);
      final transactionsJson =
          transactionObject['transactions'] as List<dynamic>;
      final transactionsListLength =
          transactionsJson is List<dynamic> ? transactionsJson.length : 0;
      final transfersJson = transactionObject['transfers'] as List<dynamic>;
      final transfersListLength =
          transfersJson is List<dynamic> ? transfersJson.length : 0;

      return List.generate(transactionsListLength + transfersListLength,
          (index) {
        if (index < transactionsListLength) {
          return Transaction.getFromJson(transactionsJson[index]);
        }
        return TransferTransaction.getFromJson(
            transfersJson[index - transactionsListLength]);
      });
    }

    return List.empty(growable: false);
  }
}
