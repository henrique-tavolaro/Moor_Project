import 'package:moor_flutter/moor_flutter.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

class SalesmanTable extends Table {
  final _uuid = Uuid();

  TextColumn get id => text().clientDefault(() => _uuid.v4())();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  TextColumn get subsidiary => text().withLength(min: 1, max: 50)();

  @override
  Set<Column> get primaryKey => {id, name};
}

class ProductsTable extends Table {
  final _uuid = Uuid();

  TextColumn get id => text().clientDefault(() => _uuid.v1())();

  TextColumn get productName => text().withLength(min: 1, max: 50)();

  RealColumn get price => real()();

  @override
  Set<Column> get primaryKey => {id, productName};
}

class OrdersTable extends Table {
  TextColumn get id => text()();

  RealColumn get totalCost => real()();

  TextColumn get status => text()();

  TextColumn get date => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class FactTable extends Table {
  final _uuid = Uuid();

  TextColumn get id => text().clientDefault(() => _uuid.v1())();

  TextColumn get orderId => text()();

  TextColumn get date => text()();

  TextColumn get salesmanId => text()();

  TextColumn get productId => text()();

  TextColumn get productName => text()();

  IntColumn get quantity => integer()();

  RealColumn get unityPrice => real()();

  RealColumn get totalPrice => real()();
}

@UseDao(tables: [FactTable])
class FactTableDao extends DatabaseAccessor<AppDatabase>
    with _$FactTableDaoMixin {
  final AppDatabase db;

  FactTableDao(this.db) : super(db);

  Future<List<FactTableData>> getAllFacts() => select(factTable).get();

  Stream<List<FactTableData>> watchAllFact() => select(factTable).watch();

  Future insertFact(FactTableCompanion fact) => into(factTable).insert(fact);
}

@UseDao(tables: [OrdersTable, FactTable])
class OrdersTableDao extends DatabaseAccessor<AppDatabase>
    with _$OrdersTableDaoMixin {
  final AppDatabase db;

  OrdersTableDao(this.db) : super(db);

  Future<List<OrdersTableData>> getAllOrders() => select(ordersTable).get();

  Future insertOrder(OrdersTableData order) => into(ordersTable).insert(order);

  Future updateOrder(OrdersTableData order) => update(ordersTable).replace(order);

  Stream<List<OrdersTableData>> watchAllOrders() => select(ordersTable).watch();

  Stream<List<OrdersTableData>> watchOpenOrders() {
    return (select(ordersTable)
      ..where((tbl) => tbl.status.equals('Open'))).watch();
  }

  Stream<List<OrdersTableData>> watchClosedOrders() {
    return (select(ordersTable)
      ..where((tbl) => tbl.status.equals('Closed'))).watch();

  }
  Stream<List<OrdersTableData>> watchCanceledOrders() {
    return (select(ordersTable)..where((tbl) => tbl.status.equals('Canceled'))).watch();
  }

  Stream<List<OrderWithFacts>> getOrderWithFacts(String id) {
    final query = (select(ordersTable))
        .join([
          innerJoin(factTable, factTable.orderId.equalsExp(ordersTable.id)),
        ]);
      query.where(ordersTable.id.equals(id));
        return query.watch()
        .map(
          (rows) => rows.map(
            (row) {
              return OrderWithFacts(
                order: row.readTable(ordersTable),
                fact: row.readTable(factTable),
              );
            },
          ).toList(),
        );
  }
}

@UseMoor(
    tables: [SalesmanTable, ProductsTable, OrdersTable, FactTable],
    daos: [SalesmanDao, ProductsDao, FactTableDao, OrdersTableDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true)));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [SalesmanTable])
class SalesmanDao extends DatabaseAccessor<AppDatabase>
    with _$SalesmanDaoMixin {
  final AppDatabase db;

  SalesmanDao(this.db) : super(db);

  Future<List<SalesmanTableData>> getAllSalesman() =>
      select(salesmanTable).get();

  Stream<List<SalesmanTableData>> watchAllSalesman() =>
      select(salesmanTable).watch();

  Future insertSalesman(SalesmanTableCompanion salesman) =>
      into(salesmanTable).insert(salesman);
}

@UseDao(tables: [ProductsTable])
class ProductsDao extends DatabaseAccessor<AppDatabase>
    with _$ProductsDaoMixin {
  final AppDatabase db;

  ProductsDao(this.db) : super(db);

  Future<List<ProductsTableData>> getAllProducts() =>
      select(productsTable).get();

  Stream<List<ProductsTableData>> watchAllProducts() =>
      select(productsTable).watch();

  Future insertProduct(ProductsTableCompanion product) =>
      into(productsTable).insert(product);
}

class OrderWithFacts {
  final OrdersTableData order;
  final FactTableData fact;

  OrderWithFacts({
    required this.order,
    required this.fact,
  });
}
