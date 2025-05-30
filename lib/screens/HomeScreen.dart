// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, use_build_context_synchronously

import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/widgets/CategoryPanel.dart';
import 'package:ecommerce/widgets/FeaturedItems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final products = provider.products;
        List<String>? categories = provider.categories;

        return Scaffold(
          appBar: AppBar(title: const Text('Zeymur Store'), centerTitle: true),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search field
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Search Term',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Image.asset(
                    'assets/image.png',
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Categorypanel(category: categories[index]);
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  if (products.isEmpty)
                    const Center(child: CircularProgressIndicator())
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categories
                          .map(
                            (cat) => Featureditems(
                              categoryTitle: cat,
                              products: provider.getProductsByCategory(cat),
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
