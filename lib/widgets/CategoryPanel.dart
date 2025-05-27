import 'package:ecommerce/providers/product_provider.dart';
import 'package:flutter/material.dart';

class Categorypanel extends StatelessWidget {
  const Categorypanel({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = ProductProvider.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: <Widget>[
            Image(
              image: AssetImage('assets/accessories.png'),
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 23,
                color: Colors.orange.withOpacity(0.9),
                alignment: AlignmentDirectional.center,
                child: Text(
                  "Accessories",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
