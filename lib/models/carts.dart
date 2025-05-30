import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/products.dart';
import 'package:json_annotation/json_annotation.dart';
part 'carts.g.dart';

@JsonSerializable()
class Cart {
  final int id;
  final int userId;
  final List<ProductModel> products;

  Cart({required this.id, required this.userId, required this.products});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);

  factory Cart.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Cart(
      id: data['id'] ?? 0,
      userId: data['userId'] ?? 0,
      products: (data['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static List<Cart> fromList(List<dynamic> data) =>
      data.map((e) => Cart.fromJson(e)).toList();

  static fromMap(Map<String, dynamic> item) {}
}
