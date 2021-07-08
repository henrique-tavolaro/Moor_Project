
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_event.dart';

import 'fact_state.dart';

class FactBloc extends Bloc<FactEvent, FactState> {

  final FactTableDao dao;

  FactBloc(this.dao) : super(InitialState());

  @override
  Stream<FactState> mapEventToState(FactEvent event) async* {
    if (event is InsertFactEvent) {
      try {
        await dao.insertFact(event.fact);
        yield InsertSuccessState(event.fact);
      } catch (e) {
        ErrorState(e.toString());
      }
    }
    if (event is GetAllFactsEvent) {
      try {
        final list = await dao.getAllFacts();
        yield GetSuccessState(list);
      } catch (e) {
        yield ErrorState(e.toString());
      }
    }
    if (event is GetSalesBySalesman) {
      try {
        final list = await dao.salesBySalesman().watch();
        yield SalesBySalesmanState(list);
      } catch (e) {
        yield ErrorState(e.toString());
      }
    }
  }
}