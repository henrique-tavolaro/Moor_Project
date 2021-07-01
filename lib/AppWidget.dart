import 'package:flutter/material.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/Pages/home_page.dart';
import 'package:project/presenter/Pages/insert_products_page.dart';
import 'package:project/presenter/Pages/insert_salesman_page.dart';
import 'package:project/presenter/Pages/orders_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
      // '/orders_page',
      '/home_page',
      routes: {
        '/home_page': (context) => HomePage(),
        '/insert_salesman': (context) => InsertSalesmanPage(),
        '/insert_product': (context) => InsertProductsPage(),
        '/orders_page': (context) => OrdersPage(),
      },
    );
  }
}
