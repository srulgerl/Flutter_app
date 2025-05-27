// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/widgets/CategoryPanel.dart';
import 'package:ecommerce/widgets/FeaturedItems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final products = provider.products;
        List<String>? categories = [];
        if (products.isNotEmpty) {
          categories = products
              .map((e) => e.category)
              .toSet()
              .take(3)
              .cast<String>()
              .toList();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Zeymur Store',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔍 Search field
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
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Categorypanel(),
                        Categorypanel(),
                        Categorypanel(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (products.isEmpty)
                    const Center(child: CircularProgressIndicator())
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categories
                          .map((cat) => Featureditems(category: cat))
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
