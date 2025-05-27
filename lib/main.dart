import 'package:ecommerce/MainScreen.dart';
import 'package:ecommerce/providers/GlobalProvider.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Globalprovider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(child: Mainscreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
