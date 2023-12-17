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

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    // Access user data from UserProvider without rebuilding the widget tree
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
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
}
