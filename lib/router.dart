import 'package:flutter/material.dart';
import 'package:omazon_ecommerce_app/common/widgets/bottom_bar.dart';
import 'package:omazon_ecommerce_app/features/address/screens/address_screen.dart';
import 'package:omazon_ecommerce_app/features/admin/screens/add_product_screen.dart';
import 'package:omazon_ecommerce_app/features/auth/screens/auth_screen.dart';
import 'package:omazon_ecommerce_app/features/home/screens/category_deals_screen.dart';
import 'package:omazon_ecommerce_app/features/home/screens/home_screen.dart';
import 'package:omazon_ecommerce_app/features/product_detail/screens/product_details_screen.dart';
import 'package:omazon_ecommerce_app/features/search/screens/search_screen.dart';
import 'package:omazon_ecommerce_app/models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddressScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen doesnt exist'),
          ),
        ),
      );
  }
}
