
import 'package:project/database/database.dart';
import 'package:project/domain/model/salesman.dart';

abstract class SalesmanRepository {
  Future<void> insertSalesman(Salesman salesman);

  Future<List<Salesman>> getAllSalesman();
}