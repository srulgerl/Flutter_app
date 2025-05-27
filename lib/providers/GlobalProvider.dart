import 'package:ecommerce/models/products.dart';
import 'package:flutter/material.dart';

class Globalprovider extends ChangeNotifier {
  List<ProductModel> _cartItems = [];
  List<ProductModel> get cartItems => _cartItems;

  List<ProductModel> _favourites = [];
  List<ProductModel> get favourites => _favourites;

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

  void addToCart(ProductModel product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void addToFavourites(ProductModel product) {
    _favourites.add(product);
    notifyListeners();
  }

  void removeFromFavourites(ProductModel product) {
    _favourites.remove(product);
    notifyListeners();
  }

  // void searchProducts(String query) {
  //   _searchResults = _products
  //       .where(
  //         (product) => product.name.toLowerCase().contains(query.toLowerCase()),
  //       )
  //       .toList();
  //   notifyListeners();
  // }

  void clearSearchResults() {
    _searchResults.clear();
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void clearFavourites() {
    _favourites.clear();
    notifyListeners();
  }

  void setCart(List<ProductModel> cart) {
    _cartItems = cart;
    notifyListeners();
  }

  void setFavourites(List<ProductModel> favourites) {
    _favourites = favourites;
    notifyListeners();
  }

  void setSearchResults(List<ProductModel> searchResults) {
    _searchResults = searchResults;
    notifyListeners();
  }

  void toggleFavourite(ProductModel product) {
    if (_favourites.contains(product)) {
      _favourites.remove(product);
    } else {
      _favourites.add(product);
    }
    notifyListeners();
  }

  void toggleCart(ProductModel product) {
    if (_cartItems.contains(product)) {
      _cartItems.remove(product);
    } else {
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void incrementProductCount(ProductModel product) {
    int index = _cartItems.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _cartItems[index].count++;
      notifyListeners();
    }
  }

  void decrementProductCount(ProductModel product) {
    int index = _cartItems.indexWhere((p) => p.id == product.id);
    if (index != -1 && _cartItems[index].count > 1) {
      _cartItems[index].count--;
      notifyListeners();
    } else if (index != -1 && _cartItems[index].count == 1) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  // ProductModel? getProductById(int id) {
  //   return _products.firstWhere(
  //     (product) => product.id == id,
  //     orElse: () => null,
  //   );
  // }

  // ProductModel? getCartProductById(int id) {
  //   return _cartItems.firstWhere((product) => product.id == id, orElse: () => null);
  // }

  // ProductModel? getFavouriteProductById(int id) {
  //   return _favourites.firstWhere(
  //     (product) => product.id == id,
  //     orElse: () => null,
  //   );
  // }

  // List<ProductModel> getProductsByCategory(String category) {
  //   return _products.where((product) => product.category == category).toList();
  // }
}
