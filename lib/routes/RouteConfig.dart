import 'package:ecommerce/MainScreen.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:ecommerce/screens/CartScreen.dart';
import 'package:ecommerce/screens/FavouriteScreen.dart';
import 'package:ecommerce/screens/HomeScreen.dart';
import 'package:ecommerce/screens/LoginScreen.dart';
import 'package:ecommerce/screens/ProductDetailScreen.dart';
import 'package:ecommerce/screens/ProductsScreen.dart';
import 'package:ecommerce/screens/RegisterScreen.dart';
import 'package:ecommerce/screens/UserProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  static GoRouter createRouter() {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: AppRoutes.home,
      redirect: (context, state) {
        final loggedIn = FirebaseAuth.instance.currentUser != null;
        final isLogin = state.matchedLocation == AppRoutes.login;
        final isRegister = state.matchedLocation == AppRoutes.register;

        if (!loggedIn && state.matchedLocation == AppRoutes.profile) {
          return AppRoutes.login;
        }

        if (loggedIn && (isLogin || isRegister)) {
          return AppRoutes.home;
        }

        return null;
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) => Mainscreen(child: child),
          routes: [
            GoRoute(
              path: AppRoutes.home,
              pageBuilder: (context, state) => _noTransitionPage(Homescreen()),
            ),
            GoRoute(
              path: AppRoutes.products,
              pageBuilder: (context, state) =>
                  _noTransitionPage(Productsscreen()),
            ),
            GoRoute(
              path: AppRoutes.cart,
              pageBuilder: (context, state) => _noTransitionPage(Cartscreen()),
            ),
            GoRoute(
              path: AppRoutes.favorites,
              pageBuilder: (context, state) =>
                  _noTransitionPage(const Favouritescreen()),
            ),
            GoRoute(
              path: AppRoutes.profile,
              pageBuilder: (context, state) =>
                  _noTransitionPage(const Userprofilescreen()),
            ),
            GoRoute(
              path: AppRoutes.productDetail,
              builder: (context, state) {
                final product = state.extra as ProductModel;
                return ProductDetailScreen(product: product);
              },
            ),
            GoRoute(
              path: AppRoutes.productsByCategory,
              pageBuilder: (context, state) {
                final category = state.pathParameters['category'];
                return _noTransitionPage(
                  Productsscreen(selectedCategory: category),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => LoginScreen(
            actions: [
              ForgotPasswordAction(((context, email) {
                final uri = Uri(
                  path: '/sign-in/forgot-password',
                  queryParameters: <String, String?>{'email': email},
                );
                context.push(uri.toString());
              })),
              AuthStateChangeAction(((context, state) {
                final user = switch (state) {
                  SignedIn(:final user) => user,
                  UserCreated(:final credential) => credential.user,
                  _ => null,
                };
                if (user == null) return;

                if (state is UserCreated) {
                  user.updateDisplayName(user.email!.split('@')[0]);
                }

                if (!user.emailVerified) {
                  user.sendEmailVerification();
                  const snackBar = SnackBar(
                    content: Text('Please verify your email'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                context.go(AppRoutes.home);
              })),
            ],
          ),
        ),
        GoRoute(
          path: AppRoutes.register,
          builder: (context, state) => Registerscreen(),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword,
          builder: (context, state) {
            final arguments = state.uri.queryParameters;
            return ForgotPasswordScreen(
              email: arguments['email'],
              headerMaxExtent: 200,
            );
          },
        ),
      ],
    );
  }

  static CustomTransitionPage _noTransitionPage(Widget child) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    );
  }
}
