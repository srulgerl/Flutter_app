import 'package:ecommerce/widgets/productView.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Categorypanel extends StatelessWidget {
  final String category;
  const Categorypanel({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/products/${Uri.encodeComponent(category)}'),
      child: Container(
        width: 130,
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
                image: AssetImage(switch (category) {
                  "men's clothing" => 'assets/mens_clothing.png',
                  "jewelery" => 'assets/accessories.png',
                  "electronics" => 'assets/electronics.png',
                  "women's clothing" => 'assets/womens_clothing.png',
                  _ => 'assets/default.png',
                }),
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
                    category.capitalizeEachWord(),
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
      ),
    );
  }
}
