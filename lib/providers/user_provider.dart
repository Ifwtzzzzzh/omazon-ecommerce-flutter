// Import packages
import 'package:flutter/cupertino.dart';
import 'package:omazon_ecommerce_app/models/user.dart';

// Provides user data and notifies listeners of changes.
class UserProvider extends ChangeNotifier {
  // Empty user instance with default values.
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  // Returns the current user (_user)
  User get user => _user;

  // Set user and notify listeners
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
