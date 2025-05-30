import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/widgets/productView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favouritescreen extends StatelessWidget {
  const Favouritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<ProductProvider>().favorites;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "favorites",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(223, 37, 37, 37),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ProductViewShop(favorites[index], "cartIcon");
              },
            ),
          ),
        ],
      ),
    );
  }
}
