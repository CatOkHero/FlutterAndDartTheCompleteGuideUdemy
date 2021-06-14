import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionsList(
    this._transactions,
    this._deleteTransaction,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (cts, index) => Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      '\$ ${_transactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _transactions[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy')
                      .format(_transactions[index].dateTime),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColorLight,
                  ),
                )
              ],
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteTransaction(_transactions[index].id),
            ),
          ],
        ),
      ),
      itemCount: _transactions.length,
    );
  }
}
