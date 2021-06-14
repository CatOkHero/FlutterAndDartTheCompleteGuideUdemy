import 'package:flutter/material.dart';
import 'package:flutter_expence_app_the_complete_guide/models/transactions.dart';
import 'package:flutter_expence_app_the_complete_guide/widgets/new_transactions.dart';
import 'package:flutter_expence_app_the_complete_guide/widgets/transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
      id: "0",
      title: "1",
      amount: 1.0,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: "1",
      title: "2",
      amount: 3.0,
      dateTime: DateTime.now(),
    )
  ];

  void _addNewTransaction(String title, String amount) {
    final transaction = new Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: double.parse(amount),
      dateTime: DateTime.now(),
    );

    setState(() {
      _transactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          NewTransaction(_addNewTransaction),
          TransactionsList(_transactions, null),
        ],
      ),
    );
  }
}
