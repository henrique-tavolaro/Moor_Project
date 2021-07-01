import 'package:equatable/equatable.dart';
import 'package:project/database/database.dart';

abstract class ProductsState extends Equatable{}

class InitialState extends ProductsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InsertSuccessState extends ProductsState {

  final ProductsTableCompanion products;

  InsertSuccessState(this.products);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ErrorState extends ProductsState {
  final String message;

  ErrorState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetSuccessState extends ProductsState {
  final List<ProductsTableData> productsList;

  GetSuccessState(this.productsList);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}