import 'package:ecommerce/providers/GlobalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Userprofilescreen extends StatelessWidget {
  const Userprofilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Globalprovider>(
      builder: (context, globalProvider, child) {
        return const Placeholder();
      },
    );
  }
}
