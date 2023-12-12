// Import the 'dart:convert' library for data conversion.
import 'dart:convert';

class User {
  // Stores user information and cart
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final List<dynamic> cart;

  // Instantiates a User object with required properties
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
  });

  // Converts object to a map representing its data.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
    };
  }

  // Creates a User object from a map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      // Extract and unwrap nullable values from map for user creation.
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      // Converts the 'cart' map entries to a List of Maps.
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  // Encodes object to JSON string using map representation.
  String toJson() => json.encode(toMap());

  // Creates User object from decoded JSON string.
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  // Creates a copy of the user with optional changes.
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    // Updating user's details with provided values or existing ones if null.
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
