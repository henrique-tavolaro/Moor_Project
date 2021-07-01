import 'package:project/database/database.dart';
import 'package:project/domain/model/salesman.dart';
import 'package:project/domain/repositories/salesman_repository.dart';

// class SalesmanRepositoryImpl extends SalesmanRepository{
//
//   final SalesmanDao dao;
//
//   SalesmanRepositoryImpl({required this.dao});
//
//   @override
//   Future<void> insertSalesman(Salesman salesman) async {
//     final SalesmanTableData salesmanModel = salesman.toMap() as SalesmanTableData;
//     await dao.insertSalesman(salesmanModel);
//     return;
//   }
//
//   @override
//   Future<List<Salesman>> getAllSalesman() async {
//     final List<SalesmanTableData> salesmanList = await dao.getAllSalesman();
//     final newsalesman = salesmanList.map((e) => e.toJson() as Salesman).toList();
//     return newsalesman;
//   }
//
//
//
// }