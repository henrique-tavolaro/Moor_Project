import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'AppWidget.dart';

void main() async {
  GetIt.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final db = AppDatabase();
    //
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<SalesmanBloc>(
    //       create: (BuildContext context) {
    //         final dao = SalesmanDao(db);
    //         // TODO dependecy injection
    //         return SalesmanBloc(dao);
    //       },
    //     ),
    //     BlocProvider<ProductsBloc>(
    //       create: (BuildContext context) {
    //         final dao = ProductsDao(db);
    //         return ProductsBloc(dao);
    //       },
    //     ),
    //     BlocProvider<OrdersBloc>(
    //       create: (BuildContext context) {
    //         final dao = OrdersTableDao(db);
    //         return OrdersBloc(dao);
    //       },
    //     ),
    //     BlocProvider<FactBloc>(
    //       create: (BuildContext context) {
    //         final dao = FactTableDao(db);
    //         return FactBloc(dao);
    //       },),
    //   ],
    //   child: MaterialApp(
    //     title: 'Sales Project',
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //     ),
    //     home: AppWidget(),
    //   ),
    // );
    return MaterialApp(
      title: 'Sales Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppWidget(),
    );
  }
}
