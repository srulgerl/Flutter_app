// ignore_for_file: avoid_print

import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/repository/product_repositroy.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepositroy _repo = ProductRepositroy();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ProductProvider() {
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      _products = await _repo.fetchProducts();
      print('Products loaded successfully: ${_products.length}');
    } catch (e) {
      print('Error loading products: $e');
      _products = [];
    }
    notifyListeners();
  }

  Future<List<ProductModel>> loadProductsByCategory(String? category) async {
    try {
      final categoryProducts = await _repo.fetchProductsByCategory(category!);
      return categoryProducts;
    } catch (e) {
      print('Error loading products by category "$category": $e');
      return [];
    }
  }
}
