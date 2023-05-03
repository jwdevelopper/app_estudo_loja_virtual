import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerencia_estado_provider/models/cart.dart';
import 'package:gerencia_estado_provider/models/order.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];
  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
