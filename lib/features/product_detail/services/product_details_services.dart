// Import packages
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:omazon_ecommerce_app/constants/error_handling.dart';
import 'package:omazon_ecommerce_app/constants/global_variables.dart';
import 'package:omazon_ecommerce_app/constants/utils.dart';
import 'package:omazon_ecommerce_app/models/product.dart';
import 'package:omazon_ecommerce_app/models/user.dart';
import 'package:omazon_ecommerce_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  // Adds a product to the cart by sending a POST request to the API
  void addToCart({
    // This function requires a BuildContext and a Product object as parameters.
    required BuildContext context,
    required Product product,
  }) async {
    // Access user data from UserProvider without rebuilding the widget tree
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      // Handles HTTP errors and updates user from response on success
      httpErrorHandled(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      // Catches any exception and displays it as a snackbar.
      showSnackBar(context, e.toString());
    }
  }

  // This function sends a post request to rate a product.
  void rateProduct({
    // Builds a product card with rating, accepting context, product and rating as arguments..
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    // Access user data from UserProvider without rebuilding the widget tree
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      // Adds product with ID "${product.id}" to cart using POST request with token.
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      // Handles HTTP errors and calls onSuccess on success.
      httpErrorHandled(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      // Catches any exception and displays it as a snackbar.
      showSnackBar(context, e.toString());
    }
  }
}
