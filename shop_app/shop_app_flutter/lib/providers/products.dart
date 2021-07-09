import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shop_app_flutter/providers/auth.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite = false;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite});

  void toggleFavoriteStete() {
    this.isFavorite = !this.isFavorite;
    notifyListeners();
  }
}

class Products with ChangeNotifier {
  List<Product> _items = [];
  Auth _auth;

  Products(this._auth, this._items);

  var showFavorites = false;

  List<Product> get items {
    if (showFavorites) {
      return _items.where((element) => element.isFavorite).toList();
    } else {
      return [..._items];
    }
  }

  void setFavorites(value) {
    showFavorites = value;
    notifyListeners();
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filtering =
        filterByUser ? '&orderBy="creatorId"&equalTo="${_auth.userId}"' : "";
    final url =
        'https://flutter-shop-app-76334-default-rtdb.firebaseio.com/products.json?auth=${_auth.token}$filtering';
    try {
      final response = await http.get(url);
      final List<Product> loadedData = [];
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      jsonData.forEach((prodId, value) {
        loadedData.add(Product(
          id: prodId,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageUrl'],
          isFavorite: value['isFavorite'],
        ));
      });
      _items = loadedData;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProducts(Product product) async {
    final url =
        'https://flutter-shop-app-76334-default-rtdb.firebaseio.com/products.json?auth=${_auth.token}';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
          'creatorId': _auth.userId
        }),
      );

      final _newProduct = Product(
        description: product.description,
        id: json.decode(response.body)['name'],
        price: product.price,
        title: product.title,
        imageUrl: product.imageUrl,
      );
      _items.add(_newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      final url =
          'https://flutter-shop-app-76334-default-rtdb.firebaseio.com/products/${product.id}.json?auth=${_auth.token}';
      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite
          }));
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    final url =
        'https://flutter-shop-app-76334-default-rtdb.firebaseio.com/products/${productId}.json?auth=${_auth.token}';
    http.delete(url);
    _items.removeWhere((element) => element.id == productId);
    notifyListeners();
  }
}
