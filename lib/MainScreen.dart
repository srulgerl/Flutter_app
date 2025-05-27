import 'package:ecommerce/providers/GlobalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/HomeScreen.dart';
import 'screens/ProductsScreen.dart';
import 'screens/CartScreen.dart';
import 'screens/UserProfileScreen.dart';
import 'screens/Favouritescreen.dart';

List<Widget> Screens = [
  Homescreen(),
  Productsscreen(),
  Cartscreen(),
  Userprofilescreen(),
  Favouritescreen(),
];

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Globalprovider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Screens[provider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            onTap: provider.changeIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: 'Profile',
              ),
            ],
            currentIndex: provider.currentIndex,
          ),
        );
      },
    );
  }
}
