import 'package:ecommerce/models/products.dart';
import 'package:flutter/material.dart';

class Globalprovider extends ChangeNotifier {
  List<ProductModel> _searchResults = [];
  List<ProductModel> get searchResults => _searchResults;

  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
