// ignore_for_file: use_build_context_synchronously, avoid_print, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/widgets/CommentSection.dart';
import 'package:ecommerce/widgets/productView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class ProductDetailScreen extends StatelessWidget {
  final ProductModel? product;
  ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(),

          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(product!.image!, height: 300),
                  ),
                ),
                const SizedBox(height: 30.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product!.title!,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'Category: ${product!.category!.capitalizeEachWord()}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 112, 110, 110),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      product!.description!.capitalize(),
                      style: const TextStyle(fontSize: 16, letterSpacing: 0.1),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      '\$${product!.price}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: product?.rating?.rate ?? 0.0,
                          itemBuilder: (context, _) =>
                              const Icon(Icons.star, color: Colors.amber),
                          itemSize: 20.0,
                        ),
                        Text(
                          '(${product?.rating?.count ?? 0})',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          cartProvider.addItem(product!);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CommentSection(productId: product!.id.toString()),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
