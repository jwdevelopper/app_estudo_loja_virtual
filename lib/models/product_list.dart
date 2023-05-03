import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/data/dummy_data.dart';
import 'package:gerencia_estado_provider/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}

/** MÉTODO GLOBAL
 * bool _showFavoriteOnly = false;

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  List<Product> get items {
    if(_showFavoriteOnly){
      return _items.where((prod) => prod.isFavorite).toList();
    }
    return [..._items];
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
 */