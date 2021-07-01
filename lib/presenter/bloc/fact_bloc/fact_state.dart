import 'package:project/database/database.dart';
import 'package:equatable/equatable.dart';

abstract class FactState extends Equatable{}

class InitialState extends FactState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InsertSuccessState extends FactState {

  final FactTableCompanion fact;

  InsertSuccessState(this.fact);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ErrorState extends FactState {
  final String message;

  ErrorState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetSuccessState extends FactState {
  final List<FactTableData> factsList;

  GetSuccessState(this.factsList);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}