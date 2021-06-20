import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "ProductDetailScreen";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context)
        .items
        .firstWhere((element) => element.id == id);
    return Container(
      child: Text(product.title),
    );
  }
}
