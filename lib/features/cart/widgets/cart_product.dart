import 'package:flutter/material.dart';
import 'package:omazon_ecommerce_app/models/product.dart';
import 'package:omazon_ecommerce_app/providers/user_provider.dart';
import 'package:provider/src/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text('Eligible for FREE  Shipping'),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'In Stock',
                      style: TextStyle(color: Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
        ),
      ],
    );
  }
}
