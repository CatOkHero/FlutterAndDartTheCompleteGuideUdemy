import 'package:flutter/material.dart';
import 'package:flutter_expence_app_the_complete_guide/models/transactions.dart';
import 'package:flutter_expence_app_the_complete_guide/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> _transactions;

  Chart(this._transactions);

  List<Map<String, Object>> get grouppedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;

      for (var i = 0; i < _transactions.length; i++) {
        if (_transactions[i].dateTime.day == weekDay.day &&
            _transactions[i].dateTime.month == weekDay.month &&
            _transactions[i].dateTime.year == weekDay.year) {
          totalSum += _transactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return grouppedTransactions.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: grouppedTransactions.map(
          (e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                e['day'].toString(),
                e['amount'],
                maxSpending == 0.0
                    ? 0.0
                    : ((e['amount'] as double) / maxSpending),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
