import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final double price;
  final int quantity;
  final String title;

  CartItem(this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Text(
                '\$${price}',
              ),
            ),
          ),
          title: Text('$title'),
          subtitle: Text('Total: \$${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
