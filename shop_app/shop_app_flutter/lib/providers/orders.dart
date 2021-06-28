import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/cart.dart';

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

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrders(List<CartItem> orders, double total) {
    //_orders.addAll(orders);
    notifyListeners();
  }

  void addOrder(OrderItem order) {
    _orders.add(order);
    notifyListeners();
  }
}
