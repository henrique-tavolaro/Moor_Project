import 'package:equatable/equatable.dart';
import 'package:project/database/database.dart';

abstract class OrdersEvent extends Equatable{}

class InsertOrdersEvent extends OrdersEvent {
  final OrdersTableData orders;

  InsertOrdersEvent(this.orders);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetAllOrdersEvent extends OrdersEvent {

  GetAllOrdersEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}