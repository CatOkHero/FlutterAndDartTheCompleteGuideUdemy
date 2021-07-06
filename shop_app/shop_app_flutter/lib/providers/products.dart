import 'dart:convert';

import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

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

  Future<void> fetchAndSetProducts() async {
    const url =
        "https://flutter-shop-app-76334-default-rtdb.firebaseio.com/products.json";
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
        "https://flutter-shop-app-76334-default-rtdb.firebaseio.com/products.json";

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
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
          "https://flutter-shop-app-76334-default-rtdb.firebaseio.com/products/${product.id}.json";
      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl
          }));
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    final url =
        "https://flutter-shop-app-76334-default-rtdb.firebaseio.com/products/${productId}.json";
    http.delete(url);
    _items.removeWhere((element) => element.id == productId);
    notifyListeners();
  }
}
