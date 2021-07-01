import 'package:equatable/equatable.dart';
import 'package:project/database/database.dart';

abstract class ProductEvent extends Equatable{}

class InsertProductEvent extends ProductEvent {
  final ProductsTableCompanion products;

  InsertProductEvent(this.products);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetAllProductsEvent extends ProductEvent {

  GetAllProductsEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}