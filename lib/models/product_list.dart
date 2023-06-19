import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/data/dummy_data.dart';
import 'package:gerencia_estado_provider/exceptions/http_exception.dart';
import 'package:gerencia_estado_provider/models/product.dart';
import 'package:gerencia_estado_provider/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  String _token;
  final String _userId;
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  ProductList([this._token = '', this._userId = '', this._items = const []]);

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'),
    );
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse('${Constants.USER_FAVORITES_BASE_URL}/$_userId.json?auth=$_token'),
    );

    Map<String,dynamic> favData = favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _items.add(Product(
        id: productId,
        name: productData['name'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        isFavorite: isFavorite
      ));
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imgUrl'] as String,
    );
    if (hasId)
      return updateProduct(product);
    else
      return addProduct(product);
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl
        },
      ),
    );
    print(json.decode(response.body));
    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl
    ));
    notifyListeners();

    // .catchError((error) {
    //   print(error.toString());
    //   throw error;
    // });
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token'),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token'),  
      );

      if(response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(msg: 'Não foi possível excluir o produto.', statusCode: response.statusCode);
      }
    }
  }

  int get itemsCount {
    return _items.length;
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