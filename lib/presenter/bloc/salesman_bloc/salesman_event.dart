
import 'package:equatable/equatable.dart';
import 'package:project/database/database.dart';

abstract class SalesmanEventBloc extends Equatable {}

class InsertSalesmanEvent extends SalesmanEventBloc {
  // final Salesman salesman;
  final SalesmanTableCompanion salesman;

  InsertSalesmanEvent(this.salesman);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetAllSalesmanEvent extends SalesmanEventBloc {

  GetAllSalesmanEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class DeleteSalesmanEvent extends SalesmanEventBloc {

  final SalesmanTableData salesman;

  DeleteSalesmanEvent(this.salesman);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

