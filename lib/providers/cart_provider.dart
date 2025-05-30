import 'dart:async';

import 'package:flutter/material.dart';
import '../models/products.dart';
import '../repository/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository _repository = CartRepository();

  List<ProductModel> _items = [];
  List<ProductModel> get items => _items;

  StreamSubscription<List<ProductModel>>? _cartSubscription;

  CartProvider() {
    _listenToCart();
  }

  void _listenToCart() {
    _cartSubscription = _repository.getCartItemsStream().listen((cart) {
      _items = cart;
      notifyListeners();
    });
  }

  Future<void> addItem(ProductModel product) =>
      _repository.addItemToCart(product);

  Future<void> removeItem(ProductModel product) =>
      _repository.removeItemFromCart(product);

  void increment(ProductModel item) async {
    int index = _items.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      _items[index].count++;
      await _repository.updateItemCount(_items[index], _items[index].count);
      notifyListeners();
    }
  }

  void decrement(ProductModel item) async {
    int index = _items.indexWhere((e) => e.id == item.id);
    if (index != -1 && _items[index].count > 1) {
      _items[index].count--;
      await _repository.updateItemCount(_items[index], _items[index].count);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _cartSubscription?.cancel();
    super.dispose();
  }
}
