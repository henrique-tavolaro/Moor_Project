import 'package:get_it/get_it.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_bloc.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_bloc.dart';
import 'package:project/presenter/bloc/product_bloc/product_bloc.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_bloc.dart';

import 'database/database.dart';

initModule(){

  final i = GetIt.instance;

  i.registerFactory(() => AppDatabase());
  i.registerFactory(() => SalesmanBloc(i()));
  i.registerFactory(() => ProductsBloc(i()));
  i.registerFactory(() => OrdersBloc(i()));
  i.registerFactory(() => FactBloc(i()));
  i.registerFactory(() => FactTableDao(i()));
  i.registerFactory(() => ProductsDao(i()));
  i.registerFactory(() => SalesmanDao(i()));
  i.registerFactory(() => OrdersTableDao(i()));


}