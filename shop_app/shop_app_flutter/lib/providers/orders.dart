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

  void addOrders(List<CartItem> products, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        products: products,
        amount: products.fold(
            0, (previousValue, element) => previousValue + element.price),
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void addOrder(OrderItem order) {
    _orders.add(order);
    notifyListeners();
  }
}
