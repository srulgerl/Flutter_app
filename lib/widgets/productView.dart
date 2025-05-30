// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/screens/ProductDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductViewShop extends StatelessWidget {
  final ProductModel data;
  final String icon;

  const ProductViewShop(this.data, this.icon, {super.key});
  _onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetailScreen(product: data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return InkWell(
          onTap: () => {_onTap(context)},
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Card(
                clipBehavior: Clip.none,
                elevation: 4.0,
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Container(
                      height: 120.0,
                      width: 120.0, // Adjust the height based on your design
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data.image!),
                        ),
                      ),
                    ),

                    icon == "favIcon"
                        ? Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 5.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5.0),
                                      TextButton(
                                        onPressed: () => {
                                          cartProvider.removeItem(data),
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),

                                  //category
                                  const SizedBox(height: 8.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data.price!.toStringAsFixed(2)}\$',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () {
                                              if (data.count > 1) {
                                                cartProvider.decrement(data);
                                              } else {
                                                cartProvider.removeItem(data);
                                              }
                                            },
                                          ),
                                          Text('${data.count}'),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              cartProvider.increment(data);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 5.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5.0),
                                      TextButton(
                                        onPressed: () => {
                                          productProvider.toggleFavorite(data),
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    data.category!.capitalizeEachWord(),
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Text(
                                        '${data.price?.toStringAsFixed(2)}\$',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                      RatingBarIndicator(
                                        rating: data.rating!.rate ?? 0.0,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemSize: 18.0,
                                      ),
                                      Text(
                                        '(${data.rating?.count!})',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),

                                      //price
                                      const SizedBox(height: 8.0),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              icon == "favIcon"
                  ? Positioned(
                      bottom: -10,
                      right: 10,
                      child: FloatingActionButton.small(
                        onPressed: () {
                          productProvider.toggleFavorite(data);
                        },
                        backgroundColor: Colors.white,
                        child: Icon(
                          productProvider.isFavorite(data)
                              ? Icons.favorite_outlined
                              : Icons.favorite_border_outlined,
                          color: Colors.red,
                          size: 18.0,
                        ),
                      ),
                    )
                  : Positioned(
                      bottom: -8,
                      right: 8,
                      child: FloatingActionButton.small(
                        onPressed: () {
                          cartProvider.addItem(data);
                          // try {
                          //   String? token = await provider.getToken();
                          //   if (token != null) {
                          //     repo.addCartItem(
                          //       userId: provider.userId as int,
                          //       productId: data.id as int,
                          //       token: token,
                          //     );
                          //     provider.addCartItem(data);
                          //   }
                          // } catch (e) {
                          //   SnackBar(content: Text("Aldaa$e"));
                          // }
                        },
                        backgroundColor: Colors.red,
                        child: const Icon(
                          Icons.card_travel,
                          color: Colors.white,
                          size: 18.0,
                        ),
                      ),
                    ),
            ],
          ),
        );

        // Row(
        //   children: [
        //     Box(
        //       height: width /3,
        //       width: width,
        //       margin: EdgeInsets.only(right: 10),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(8),
        //         image: DecorationImage(image: NetworkImage(data.image!), fit: BoxFit.fitHeight)
        //       ),
        //     ),
        //      Column(
        //       children: [
        //         Text(data.title==null?"": data.title!),
        //         Text(data.category==null?"": data.category!),
        //         Text('${data.price}'),
        //       ],
        //     )

        //   ],
        // );
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
