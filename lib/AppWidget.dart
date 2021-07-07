import 'package:flutter/material.dart';
import 'package:project/database/database.dart';
import 'package:project/injection_module.dart';
import 'package:project/presenter/Pages/dashboard_page.dart';
import 'package:project/presenter/Pages/home_page.dart';
import 'package:project/presenter/Pages/insert_products/insert_products_page.dart';
import 'package:project/presenter/Pages/insert_salesman/insert_salesman_page.dart';
import 'package:project/presenter/Pages/orders_page.dart';
import 'package:project/presenter/Pages/register_orders_page.dart';

import 'Theme/AppColors.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  @override
  void initState() {
    super.initState();
    initModule();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Project',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primaryLight,
        // primarySwatch: Colors.yellow,
        primaryColor: AppColors.primary,
      ),
      initialRoute:
      // '/orders_page',
      '/home_page',
      routes: {
        '/home_page': (context) => HomePage(),
        '/insert_salesman': (context) => InsertSalesmanPage(),
        '/insert_product': (context) => InsertProductsPage(),
        '/register_orders_page': (context) => RegisterOrdersPage(),
        '/orders_page': (context) => OrdersPage(),
        '/dashboard_page': (context) => DashboardPage(),
      },
    );
  }
}
