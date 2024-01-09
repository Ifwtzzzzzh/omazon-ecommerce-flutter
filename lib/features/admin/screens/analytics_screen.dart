import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omazon_ecommerce_app/common/widgets/loader.dart';
import 'package:omazon_ecommerce_app/features/admin/models/sales.dart';
import 'package:omazon_ecommerce_app/features/admin/services/admin_services.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  // Called when the widget is first created and it calls the getEarnings function.
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  // Retrieves earnings data from the admin services and updates the total sales and earnings variables.
  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text('\$$totalSales',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          );
  }
}
