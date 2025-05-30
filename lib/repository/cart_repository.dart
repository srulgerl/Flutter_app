import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/products.dart';

class CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get userId => _auth.currentUser?.uid;

  /// Бүтээгдэхүүн сагсанд нэмэх
  Future<void> addItemToCart(ProductModel product) async {
    if (userId == null) return;

    await _firestore.collection('cart').doc(userId).set({
      'items': FieldValue.arrayUnion([product.toMap()]),
    }, SetOptions(merge: true));
  }

  /// Бүтээгдэхүүнийг сагснаас устгах
  Future<void> removeItemFromCart(ProductModel product) async {
    if (userId == null) return;

    await _firestore.collection('cart').doc(userId).update({
      'items': FieldValue.arrayRemove([product.toMap()]),
    });
  }

  /// Сагсанд байгаа бүх бүтээгдэхүүнийг буцаах (stream хэлбэрээр)
  Stream<List<ProductModel>> getCartItemsStream() {
    if (userId == null) return const Stream.empty();

    return _firestore.collection('cart').doc(userId).snapshots().map((doc) {
      if (doc.exists && doc.data()?['items'] != null) {
        final items = doc.data()!['items'] as List;
        return items.map((e) => ProductModel.fromMap(e)).toList();
      } else {
        return [];
      }
    });
  }

  /// Сагсыг цэвэрлэх
  Future<void> clearCart() async {
    if (userId == null) return;

    await _firestore.collection('cart').doc(userId).set({'items': []});
  }

  Future<void> updateItemCount(ProductModel product, int count) async {
    if (userId == null) return;

    final docRef = _firestore.collection('cart').doc(userId);

    final updatedItem = product.toMap()..['count'] = count;

    final doc = await docRef.get();
    if (!doc.exists) return;

    final data = doc.data();
    final items = (data?['items'] as List<dynamic>?) ?? [];

    // Remove old item by matching id or title
    items.removeWhere((item) => item['id'] == product.id);

    // Add updated item
    items.add(updatedItem);

    await docRef.update({'items': items});
  }
}
