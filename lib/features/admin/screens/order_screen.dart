import 'package:flutter/material.dart';
import 'package:omazon_ecommerce_app/common/widgets/loader.dart';
import 'package:omazon_ecommerce_app/features/account/widgets/single_product.dart';
import 'package:omazon_ecommerce_app/features/admin/services/admin_services.dart';
import 'package:omazon_ecommerce_app/features/order_details/screen/order_details.dart';
import 'package:omazon_ecommerce_app/models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  // Used to initialize the state of a widget, and in this case, it is being used to fetch orders.
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  // Fetches all orders using admin services and updates the state.
  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailScreen.routeName,
                      arguments: orderData);
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    image: orderData.products[0].images[0],
                  ),
                ),
              );
            },
          );
  }
}
