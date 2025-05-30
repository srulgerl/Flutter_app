import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/services/httpService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductRepositroy {
  final HttpService http = HttpService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  Future<List<ProductModel>> fetchProducts() async {
    await Future.delayed(Duration(seconds: 2));
    return http.getAllProducts('products', null);
  }

  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    await Future.delayed(Duration(seconds: 2));
    return http.getAllProducts('products/category/$category', null);
  }

  Future<void> addFavorite(ProductModel product) async {
    if (_uid == null) return;
    final docRef = _firestore.collection('favorites').doc(_uid);
    await docRef.set({
      'items': FieldValue.arrayUnion([product.toMap()]),
    }, SetOptions(merge: true));
  }

  Future<void> removeFavorite(ProductModel product) async {
    if (_uid == null) return;
    final docRef = _firestore.collection('favorites').doc(_uid);
    await docRef.update({
      'items': FieldValue.arrayRemove([product.toMap()]),
    });
  }

  Stream<List<ProductModel>> getFavoritesStream() {
    if (_uid == null) {
      return Stream.value([]);
    }

    return _firestore.collection('favorites').doc(_uid).snapshots().map((
      snapshot,
    ) {
      if (!snapshot.exists || snapshot.data()?['items'] == null) {
        return [];
      }
      final items = snapshot.data()!['items'] as List;
      return items.map((e) => ProductModel.fromMap(e)).toList();
    });
  }
}
