import 'package:project/database/database.dart';
import 'package:equatable/equatable.dart';

abstract class OrdersState extends Equatable{}

class InitialState extends OrdersState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InsertSuccessState extends OrdersState {

  final OrdersTableData order;

  InsertSuccessState(this.order);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ErrorState extends OrdersState {
  final String message;

  ErrorState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetSuccessState extends OrdersState {
  final List<OrdersTableData> ordersList;

  GetSuccessState(this.ordersList);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}