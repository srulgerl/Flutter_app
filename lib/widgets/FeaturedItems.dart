// ignore_for_file: file_names

import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/screens/ProductDetailScreen.dart';
import 'package:ecommerce/widgets/ProductCard.dart';
import 'package:flutter/material.dart';

class Featureditems extends StatelessWidget {
  final String categoryTitle;
  final List<ProductModel> products;

  const Featureditems({
    super.key,
    required this.categoryTitle,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Optionally go to full category screen
              },
              child: const Text(
                "Show All",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.orange,
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        ),

        // Products
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: products[index]),
                    ),
                  );
                },
                child: Productcard(product: products[index]),
              );
            },
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
