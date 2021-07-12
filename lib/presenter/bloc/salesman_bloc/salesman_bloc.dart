
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_event.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_state.dart';

class SalesmanBloc extends Bloc<SalesmanEventBloc, SalesmanStateBloc> {

  final SalesmanDao dao;

  SalesmanBloc(this.dao) : super(InitialState());

  @override
  Stream<SalesmanStateBloc> mapEventToState(SalesmanEventBloc event) async* {
    if (event is InsertSalesmanEvent) {
      try {

        await dao.insertSalesman(event.salesman);
        yield InsertSuccessState(event.salesman);
      } catch (e) {
        yield ErrorState(e.toString());
      }
    }
    if (event is GetAllSalesmanEvent) {
      try{
        final list = await dao.getAllSalesman();
        yield GetSalesmanSuccessState(list);
      } catch(e) {
        yield ErrorState(e.toString());
      }
    }
    if (event is DeleteSalesmanEvent) {
      try{
        final list = await dao.deleteSalesman(event.salesman);
        yield DeleteSalesmanSuccessState();
      } catch(e) {
        yield ErrorState(e.toString());
      }
    }
  }


}