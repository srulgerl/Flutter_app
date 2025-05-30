import 'package:ecommerce/providers/app_auth_provider.dart'; // Fixed: lowercase 'auth_provider'
import 'package:ecommerce/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Mainscreen extends StatelessWidget {
  final Widget child;

  const Mainscreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).matchedLocation;
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _getCurrentIndex(currentLocation),
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'Products',
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
      ),
    );
  }

  int _getCurrentIndex(String location) {
    if (location.startsWith('/products')) return 1;
    switch (location) {
      case AppRoutes.home:
        return 0;
      case AppRoutes.products:
        return 1;
      case AppRoutes.cart:
        return 2;
      case AppRoutes.favorites:
        return 3;
      case AppRoutes.profile:
        return 4;
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    final auth = Provider.of<AppAuthProvider>(context, listen: false);

    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.products);
        break;
      case 2:
        context.go(AppRoutes.cart);
        break;
      case 3:
        context.go(AppRoutes.favorites);
        break;

      case 4:
        if (auth.loggedIn) {
          context.go(AppRoutes.profile);
        } else {
          context.go(AppRoutes.login);
        }
        break;
    }
  }
}
