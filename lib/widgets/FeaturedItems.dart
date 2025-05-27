import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/widgets/ProductCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Featureditems extends StatelessWidget {
  final String? category;
  const Featureditems({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );

    return FutureBuilder(
      future: category != null
          ? productProvider.loadProductsByCategory(category!)
          : Future.value([]),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final categoryProducts = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (category ?? '').capitalizeEachWord(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
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

            // Product List
            SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categoryProducts.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return Productcard(product: categoryProducts[index]);
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}

extension StringCasingExtension on String {
  String capitalizeEachWord() {
    return split(' ')
        .map(
          (word) =>
              word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '',
        )
        .join(' ');
  }
}
