import 'package:project/database/database.dart';
import 'package:equatable/equatable.dart';

abstract class FactEvent extends Equatable{}

class InsertFactEvent extends FactEvent {
  final FactTableCompanion fact;

  InsertFactEvent(this.fact);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetAllFactsEvent extends FactEvent {

  GetAllFactsEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class GetSalesBySalesman extends FactEvent {

  GetSalesBySalesman();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();



}