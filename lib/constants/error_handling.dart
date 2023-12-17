// Import packages.
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:omazon_ecommerce_app/constants/utils.dart';

// Handles HTTP errors based on status code, showing snackbars for failures
void httpErrorHandled({
  // Callback on successful API response & rebuild UI
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  // Handles HTTP response based on status code, showing success/error messages as snackbars.
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
