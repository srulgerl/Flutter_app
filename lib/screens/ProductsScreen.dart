import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/widgets/ProductCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Productsscreen extends StatelessWidget {
  final String? selectedCategory;

  Productsscreen({super.key, this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final products = selectedCategory == null
        ? productProvider.products
        : productProvider.getProductsByCategory(selectedCategory!);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory ?? 'All Products'),
        centerTitle: true,
        actions: [
          Icon(Icons.filter_list),
          SizedBox(width: 10),
          Icon(Icons.tune),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter search term",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return Productcard(product: product); // ✅ ЗӨВ АШИГЛАЛТ
              },
            ),
          ),
        ],
      ),
    );
  }
}
