import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart.dart';
import 'package:shop_app_flutter/providers/products.dart';
import 'package:shop_app_flutter/screens/cart_screen.dart';
import 'package:shop_app_flutter/widgets/app_drawer.dart';
import 'package:shop_app_flutter/widgets/badge.dart';
import 'package:shop_app_flutter/widgets/products_grid.dart';

enum PopupEnum { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _isInit = true;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      Provider.of<Products>(context).fetchAndSetProducts();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shopping app"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (PopupEnum onSelectedValue) =>
                {products.setFavorites(onSelectedValue == PopupEnum.Favorites)},
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: PopupEnum.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: PopupEnum.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, data, child) => Badge(
              child: child,
              value: data.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(),
    );
  }
}
