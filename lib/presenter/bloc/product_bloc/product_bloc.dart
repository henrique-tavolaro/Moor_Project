import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/bloc/product_bloc/product_event.dart';
import 'package:project/presenter/bloc/product_bloc/product_state.dart';

class ProductsBloc extends Bloc<ProductEvent, ProductsState> {

  final ProductsDao dao;

  ProductsBloc(this.dao) : super(InitialState());

  @override
  Stream<ProductsState> mapEventToState(ProductEvent event) async* {
    if(event is InsertProductEvent){
      try{
        await dao.insertProduct(event.products);
        yield InsertSuccessState(event.products);
      } catch(e){
        ErrorState(e.toString());
      }
    }
    if(event is GetAllProductsEvent){
      try{
        final list = await dao.getAllProducts();
        yield GetSuccessState(list);
      } catch(e) {
        yield ErrorState(e.toString());
      }
    }
  }
}