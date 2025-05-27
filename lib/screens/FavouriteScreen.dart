import 'package:ecommerce/providers/GlobalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favouritescreen extends StatelessWidget {
  const Favouritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Globalprovider>(
      builder: (context, provider, child) {
        return const Placeholder();
      },
    );
  }
}
