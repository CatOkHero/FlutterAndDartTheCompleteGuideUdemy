import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/products.dart';
import 'package:shop_app_flutter/screens/edit_product_screen.dart';
import 'package:shop_app_flutter/widgets/app_drawer.dart';
import 'package:shop_app_flutter/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "User_Products_Screen";

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yout products'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () {
          _refreshProducts(context);
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, i) => UserProductItem(products.items[i].id,
                products.items[i].title, products.items[i].imageUrl),
            itemCount: products.items.length,
          ),
        ),
      ),
    );
  }
}
