// import 'package:project/database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_event.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {

  final OrdersTableDao dao;

  OrdersBloc(this.dao) : super(InitialState());

  @override
  Stream<OrdersState> mapEventToState(OrdersEvent event) async* {
    if(event is InsertOrdersEvent){
      try{
        await dao.insertOrder(event.orders);
        yield InsertSuccessState(event.orders);
      } catch(e){
        ErrorState(e.toString());
      }
    }
    if(event is GetAllOrdersEvent){
      try{
        final list = await dao.getAllOrders();
        yield GetSuccessState(list);
      } catch(e) {
        yield ErrorState(e.toString());
      }
    }
  }
}