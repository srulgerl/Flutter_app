import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/repository/cart_repository.dart';
import 'package:ecommerce/widgets/productView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cartscreen extends StatelessWidget {
  Cartscreen({super.key});

  final repo = CartRepository();

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, provider, child) {
        double total = provider.items.fold(
          0,
          (sum, item) => sum + (item.price! * item.count),
        );
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Cart",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(223, 37, 37, 37),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                provider.items.isEmpty
                    ? Center(
                        child: Text(
                          "Cart is empty",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: provider.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductViewShop(
                              provider.items[index],
                              "favIcon",
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total ${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Payment successful!")),
                    );
                  },
                  child: Text("Buy"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
