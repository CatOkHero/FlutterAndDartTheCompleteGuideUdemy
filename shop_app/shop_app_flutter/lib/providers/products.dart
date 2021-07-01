import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      isFavorite: false,
    ),
  ];

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

  void addProducts(Product product) {
    final _newProduct = Product(
      description: product.description,
      id: DateTime.now().toString(),
      price: product.price,
      title: product.title,
      imageUrl: product.imageUrl,
    );
    _items.add(_newProduct);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    _items.removeWhere((element) => element.id == productId);
    notifyListeners();
  }
}
