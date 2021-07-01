
import 'package:equatable/equatable.dart';
import 'package:project/database/database.dart';
import 'package:project/domain/model/salesman.dart';

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

