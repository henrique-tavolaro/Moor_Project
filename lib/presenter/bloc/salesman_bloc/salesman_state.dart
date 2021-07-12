
import 'package:equatable/equatable.dart';
import 'package:project/database/database.dart';

abstract class SalesmanStateBloc extends Equatable{}

class InitialState extends SalesmanStateBloc{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InsertSuccessState extends SalesmanStateBloc {

  // final Salesman salesman;
  final SalesmanTableCompanion salesman;

  InsertSuccessState(this.salesman);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ErrorState extends SalesmanStateBloc {
  final String message;

  ErrorState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetSalesmanSuccessState extends SalesmanStateBloc {
  final List<SalesmanTableData> salesmanList;

  GetSalesmanSuccessState(this.salesmanList);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class DeleteSalesmanSuccessState extends SalesmanStateBloc {

  DeleteSalesmanSuccessState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}