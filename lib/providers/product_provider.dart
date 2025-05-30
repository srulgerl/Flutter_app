// ignore_for_file: avoid_print

import 'dart:async';

import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/repository/product_repositroy.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepositroy _repo = ProductRepositroy();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  List<ProductModel> _favorites = [];
  List<ProductModel> get favorites => _favorites;
  StreamSubscription<List<ProductModel>>? _favSubscription;

  List<String> _categories = [];
  List<String> get categories => _categories;

  ProductProvider() {
    loadProducts();
    _listenToFavorites();
  }

  Future<void> loadProducts() async {
    if (_products.isNotEmpty) {
      print('Products already loaded: ${_products.length}');
      return;
    }

    try {
      _products = await _repo.fetchProducts();
      _categories = _products
          .map((e) => e.category)
          .where((element) => element != null)
          .toSet()
          .cast<String>()
          .toList();

      print('Products loaded successfully: ${_products.length}');
    } catch (e) {
      print('Error loading products: $e');
      _products = [];
      _categories = [];
    }

    notifyListeners();
  }

  List<ProductModel> getProductsByCategory(String category) {
    return _products.where((p) => p.category == category).toList();
  }

  void _listenToFavorites() {
    _favSubscription = _repo.getFavoritesStream().listen((list) {
      _favorites = list;
      notifyListeners();
    });
  }

  void setFavorite(ProductModel item) {
    final index = _products.indexWhere((p) => p.id == item.id);
    if (index != -1) {
      _products[index].isFavorite = !_products[index].isFavorite;
    }
    notifyListeners();
  }

  bool isFavorite(ProductModel product) {
    return _favorites.any((e) => e.id == product.id);
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final isFav = isFavorite(product);
    if (isFav) {
      await _repo.removeFavorite(product);
      notifyListeners();
    } else {
      await _repo.addFavorite(product);
    }
  }

  @override
  void dispose() {
    _favSubscription?.cancel();
    super.dispose();
  }
}
