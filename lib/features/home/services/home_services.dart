import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:omazon_ecommerce_app/constants/error_handling.dart';
import 'package:omazon_ecommerce_app/constants/global_variables.dart';
import 'package:omazon_ecommerce_app/constants/utils.dart';
import 'package:omazon_ecommerce_app/models/product.dart';
import 'package:omazon_ecommerce_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  // This function fetches a list of products for a specific category.
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    // Get the UserProvider without listening for changes
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      // Send a GET request to the API endpoint.
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      // Handle any potential network or server errors.
      httpErrorHandled(
        response: res,
        context: context,
        onSuccess: () {
          // Iterates through the decoded JSON response and adds each product to the product list.
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      // Show an error snackbar to inform the user.
      showSnackBar(context, e.toString());
    }
    // Returns the list of products.
    return productList;
  }

  // Fetches the Deal of the Day product from the API.
  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    // Initializes a Product object and fetches the UserProvider without listening for updates
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      // Send a GET request to the API endpoint.
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      // Handle any potential network or server errors.
      httpErrorHandled(
        response: res,
        context: context,
        onSuccess: () {
          // Parse the response body as JSON and create a Product object.
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      // Show an error snackbar to inform the user.
      showSnackBar(context, e.toString());
    }
    // Return the fetched product data.
    return product;
  }
}
