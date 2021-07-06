import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/orders.dart' as ord;
import 'package:shop_app_flutter/widgets/app_drawer.dart';
import 'package:shop_app_flutter/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "Orders_Screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<ord.Orders>(context, listen: false).fetchOreders(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error == null) {
              return Consumer<ord.Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemBuilder: (ctx, index) =>
                      OrderItem(orderData.orders[index]),
                  itemCount: orderData.orders.length,
                ),
              );
            } else {
              return Center(
                child: Text('Something wrong happened, please try again later'),
              );
            }
          }
        },
      ),
    );
  }
}
