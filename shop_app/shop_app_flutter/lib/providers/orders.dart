import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/auth.dart';
import 'package:shop_app_flutter/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  Auth _auth;

  Orders(this._auth, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrders(List<CartItem> products, double total) async {
    final url =
        "https://flutter-shop-app-76334-default-rtdb.firebaseio.com/orders/${_auth.userId}.json?auth=${_auth.token}";

    try {
      final dateTime = DateTime.now();
      final response = await http.post(
        url,
        body: json.encode({
          'products': products
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'price': e.price,
                    'quantity': e.quantity
                  })
              .toList(),
          'amount': products.fold(
              0, (previousValue, element) => previousValue + element.price),
          'dateTime': dateTime.toIso8601String(),
        }),
      );

      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          products: products,
          amount: products.fold(
              0, (previousValue, element) => previousValue + element.price),
          dateTime: dateTime,
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchOreders() async {
    final url =
        "https://flutter-shop-app-76334-default-rtdb.firebaseio.com/orders/${_auth.userId}.json?auth=${_auth.token}";

    try {
      final dateTime = DateTime.now();
      final response = await http.get(url);
      final List<OrderItem> _ordersExtracted = [];
      final _extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (_extractedData == null) {
        return;
      }

      _extractedData.forEach((key, value) {
        _ordersExtracted.add(OrderItem(
          id: json.decode(response.body)['name'],
          products: (value['products'] as List<dynamic>)
              .map((e) => CartItem(
                  id: e['id'],
                  title: e['title'],
                  price: e['price'],
                  quantity: e['quantity']))
              .toList(),
          amount: value['amount'],
          dateTime: DateTime.parse(value['dateTime']),
        ));
      });

      _orders = _ordersExtracted.reversed.toList();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
