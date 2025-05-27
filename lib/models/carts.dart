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

  static List<Cart> fromList(List<dynamic> data) =>
      data.map((e) => Cart.fromJson(e)).toList();
}
