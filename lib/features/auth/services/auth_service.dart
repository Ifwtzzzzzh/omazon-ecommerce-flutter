import 'package:omazon_ecommerce_app/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // SIGN UP USER
  void signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      // http.post(url)
    } catch (e) {}
  }
}
