import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expence_app_the_complete_guide/widgets/chart.dart';
import 'package:flutter_expence_app_the_complete_guide/widgets/new_transactions.dart';
import 'package:flutter_expence_app_the_complete_guide/widgets/transaction_list.dart';

import 'models/transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            title: 'Flutter Demo',
            // theme: ThemeData(
            //   primarySwatch: Colors.orange,
            //   accentColor: Colors.white,
            //   visualDensity: VisualDensity.adaptivePlatformDensity,
            // ),
            home: MyHomePage('Flutter Demo Home Page'),
          )
        : MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              accentColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: MyHomePage('Flutter Demo Home Page'),
          );
  }
}

class MyHomePage extends StatefulWidget {
  final String _title;

  MyHomePage(this._title);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: "0",
      title: "0",
      amount: 1.0,
      dateTime: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: "1",
      title: "2",
      amount: 1.0,
      dateTime: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: "2",
      title: "3",
      amount: 1.0,
      dateTime: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "3",
      title: "4",
      amount: 1.0,
      dateTime: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "4",
      title: "5",
      amount: 1.0,
      dateTime: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: "5",
      title: "6",
      amount: 1.0,
      dateTime: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: "6",
      title: "7",
      amount: 3.0,
      dateTime: DateTime.now(),
    )
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) => element.dateTime.isAfter(
              DateTime.now().subtract(Duration(days: 7)),
            ))
        .toList();
  }

  bool isSwitched = false;

  void _addNewTransaction(String title, String amount, DateTime selectedDate) {
    final transaction = new Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: double.parse(amount),
      dateTime: selectedDate,
    );

    setState(() {
      _transactions.add(transaction);
    });
  }

  void onNewStansaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (btx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(widget._title),
            trailing: GestureDetector(
              child: Icon(CupertinoIcons.add),
              onTap: () => onNewStansaction(context),
            ),
          )
        : AppBar(
            title: Text(widget._title),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => onNewStansaction(context),
              )
            ],
          );
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final leftHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final chartHeight = isLandscape ? leftHeight * 0.7 : leftHeight * 0.3;
    final transactionsHeight = leftHeight * 0.7;

    final transactions = Container(
      height: transactionsHeight,
      child: TransactionsList(_transactions, _deleteTransaction),
    );

    final chart = Container(
      height: chartHeight,
      child: Chart(_recentTransactions),
    );

    final landScapeViews = isSwitched ? chart : transactions;
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                children: [
                  Switch.adaptive(
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    value: isSwitched,
                  ),
                ],
              ),
            if (isLandscape) landScapeViews,
            if (!isLandscape) chart,
            if (!isLandscape) transactions,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => onNewStansaction(context),
                  ),
          );
  }
}
