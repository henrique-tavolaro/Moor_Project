// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SalesmanTableData extends DataClass
    implements Insertable<SalesmanTableData> {
  final String id;
  final String name;
  final String subsidiary;
  SalesmanTableData(
      {required this.id, required this.name, required this.subsidiary});
  factory SalesmanTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SalesmanTableData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      subsidiary: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}subsidiary'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['subsidiary'] = Variable<String>(subsidiary);
    return map;
  }

  SalesmanTableCompanion toCompanion(bool nullToAbsent) {
    return SalesmanTableCompanion(
      id: Value(id),
      name: Value(name),
      subsidiary: Value(subsidiary),
    );
  }

  factory SalesmanTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SalesmanTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      subsidiary: serializer.fromJson<String>(json['subsidiary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'subsidiary': serializer.toJson<String>(subsidiary),
    };
  }

  SalesmanTableData copyWith({String? id, String? name, String? subsidiary}) =>
      SalesmanTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        subsidiary: subsidiary ?? this.subsidiary,
      );
  @override
  String toString() {
    return (StringBuffer('SalesmanTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('subsidiary: $subsidiary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, subsidiary.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesmanTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.subsidiary == this.subsidiary);
}

class SalesmanTableCompanion extends UpdateCompanion<SalesmanTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> subsidiary;
  const SalesmanTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.subsidiary = const Value.absent(),
  });
  SalesmanTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String subsidiary,
  })  : name = Value(name),
        subsidiary = Value(subsidiary);
  static Insertable<SalesmanTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? subsidiary,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (subsidiary != null) 'subsidiary': subsidiary,
    });
  }

  SalesmanTableCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<String>? subsidiary}) {
    return SalesmanTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      subsidiary: subsidiary ?? this.subsidiary,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (subsidiary.present) {
      map['subsidiary'] = Variable<String>(subsidiary.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesmanTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('subsidiary: $subsidiary')
          ..write(')'))
        .toString();
  }
}

class $SalesmanTableTable extends SalesmanTable
    with TableInfo<$SalesmanTableTable, SalesmanTableData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SalesmanTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => _uuid.v4();
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _subsidiaryMeta = const VerificationMeta('subsidiary');
  @override
  late final GeneratedTextColumn subsidiary = _constructSubsidiary();
  GeneratedTextColumn _constructSubsidiary() {
    return GeneratedTextColumn('subsidiary', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, subsidiary];
  @override
  $SalesmanTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'salesman_table';
  @override
  final String actualTableName = 'salesman_table';
  @override
  VerificationContext validateIntegrity(Insertable<SalesmanTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('subsidiary')) {
      context.handle(
          _subsidiaryMeta,
          subsidiary.isAcceptableOrUnknown(
              data['subsidiary']!, _subsidiaryMeta));
    } else if (isInserting) {
      context.missing(_subsidiaryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, name};
  @override
  SalesmanTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SalesmanTableData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SalesmanTableTable createAlias(String alias) {
    return $SalesmanTableTable(_db, alias);
  }
}

class ProductsTableData extends DataClass
    implements Insertable<ProductsTableData> {
  final String id;
  final String productName;
  final double price;
  ProductsTableData(
      {required this.id, required this.productName, required this.price});
  factory ProductsTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductsTableData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_name'])!,
      price: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_name'] = Variable<String>(productName);
    map['price'] = Variable<double>(price);
    return map;
  }

  ProductsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductsTableCompanion(
      id: Value(id),
      productName: Value(productName),
      price: Value(price),
    );
  }

  factory ProductsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductsTableData(
      id: serializer.fromJson<String>(json['id']),
      productName: serializer.fromJson<String>(json['productName']),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productName': serializer.toJson<String>(productName),
      'price': serializer.toJson<double>(price),
    };
  }

  ProductsTableData copyWith(
          {String? id, String? productName, double? price}) =>
      ProductsTableData(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('ProductsTableData(')
          ..write('id: $id, ')
          ..write('productName: $productName, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(productName.hashCode, price.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsTableData &&
          other.id == this.id &&
          other.productName == this.productName &&
          other.price == this.price);
}

class ProductsTableCompanion extends UpdateCompanion<ProductsTableData> {
  final Value<String> id;
  final Value<String> productName;
  final Value<double> price;
  const ProductsTableCompanion({
    this.id = const Value.absent(),
    this.productName = const Value.absent(),
    this.price = const Value.absent(),
  });
  ProductsTableCompanion.insert({
    this.id = const Value.absent(),
    required String productName,
    required double price,
  })  : productName = Value(productName),
        price = Value(price);
  static Insertable<ProductsTableData> custom({
    Expression<String>? id,
    Expression<String>? productName,
    Expression<double>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productName != null) 'product_name': productName,
      if (price != null) 'price': price,
    });
  }

  ProductsTableCompanion copyWith(
      {Value<String>? id, Value<String>? productName, Value<double>? price}) {
    return ProductsTableCompanion(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableCompanion(')
          ..write('id: $id, ')
          ..write('productName: $productName, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

class $ProductsTableTable extends ProductsTable
    with TableInfo<$ProductsTableTable, ProductsTableData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ProductsTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => _uuid.v1();
  }

  final VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedTextColumn productName = _constructProductName();
  GeneratedTextColumn _constructProductName() {
    return GeneratedTextColumn('product_name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedRealColumn price = _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn(
      'price',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, productName, price];
  @override
  $ProductsTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'products_table';
  @override
  final String actualTableName = 'products_table';
  @override
  VerificationContext validateIntegrity(Insertable<ProductsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, productName};
  @override
  ProductsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProductsTableData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductsTableTable createAlias(String alias) {
    return $ProductsTableTable(_db, alias);
  }
}

class OrdersTableData extends DataClass implements Insertable<OrdersTableData> {
  final String id;
  final double totalCost;
  final String status;
  final String date;
  OrdersTableData(
      {required this.id,
      required this.totalCost,
      required this.status,
      required this.date});
  factory OrdersTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return OrdersTableData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      totalCost: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_cost'])!,
      status: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status'])!,
      date: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['total_cost'] = Variable<double>(totalCost);
    map['status'] = Variable<String>(status);
    map['date'] = Variable<String>(date);
    return map;
  }

  OrdersTableCompanion toCompanion(bool nullToAbsent) {
    return OrdersTableCompanion(
      id: Value(id),
      totalCost: Value(totalCost),
      status: Value(status),
      date: Value(date),
    );
  }

  factory OrdersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return OrdersTableData(
      id: serializer.fromJson<String>(json['id']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      status: serializer.fromJson<String>(json['status']),
      date: serializer.fromJson<String>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'totalCost': serializer.toJson<double>(totalCost),
      'status': serializer.toJson<String>(status),
      'date': serializer.toJson<String>(date),
    };
  }

  OrdersTableData copyWith(
          {String? id, double? totalCost, String? status, String? date}) =>
      OrdersTableData(
        id: id ?? this.id,
        totalCost: totalCost ?? this.totalCost,
        status: status ?? this.status,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('OrdersTableData(')
          ..write('id: $id, ')
          ..write('totalCost: $totalCost, ')
          ..write('status: $status, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(totalCost.hashCode, $mrjc(status.hashCode, date.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdersTableData &&
          other.id == this.id &&
          other.totalCost == this.totalCost &&
          other.status == this.status &&
          other.date == this.date);
}

class OrdersTableCompanion extends UpdateCompanion<OrdersTableData> {
  final Value<String> id;
  final Value<double> totalCost;
  final Value<String> status;
  final Value<String> date;
  const OrdersTableCompanion({
    this.id = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.status = const Value.absent(),
    this.date = const Value.absent(),
  });
  OrdersTableCompanion.insert({
    required String id,
    required double totalCost,
    required String status,
    required String date,
  })  : id = Value(id),
        totalCost = Value(totalCost),
        status = Value(status),
        date = Value(date);
  static Insertable<OrdersTableData> custom({
    Expression<String>? id,
    Expression<double>? totalCost,
    Expression<String>? status,
    Expression<String>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalCost != null) 'total_cost': totalCost,
      if (status != null) 'status': status,
      if (date != null) 'date': date,
    });
  }

  OrdersTableCompanion copyWith(
      {Value<String>? id,
      Value<double>? totalCost,
      Value<String>? status,
      Value<String>? date}) {
    return OrdersTableCompanion(
      id: id ?? this.id,
      totalCost: totalCost ?? this.totalCost,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersTableCompanion(')
          ..write('id: $id, ')
          ..write('totalCost: $totalCost, ')
          ..write('status: $status, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $OrdersTableTable extends OrdersTable
    with TableInfo<$OrdersTableTable, OrdersTableData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $OrdersTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalCostMeta = const VerificationMeta('totalCost');
  @override
  late final GeneratedRealColumn totalCost = _constructTotalCost();
  GeneratedRealColumn _constructTotalCost() {
    return GeneratedRealColumn(
      'total_cost',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedTextColumn status = _constructStatus();
  GeneratedTextColumn _constructStatus() {
    return GeneratedTextColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedTextColumn date = _constructDate();
  GeneratedTextColumn _constructDate() {
    return GeneratedTextColumn(
      'date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, totalCost, status, date];
  @override
  $OrdersTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'orders_table';
  @override
  final String actualTableName = 'orders_table';
  @override
  VerificationContext validateIntegrity(Insertable<OrdersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('total_cost')) {
      context.handle(_totalCostMeta,
          totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta));
    } else if (isInserting) {
      context.missing(_totalCostMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return OrdersTableData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $OrdersTableTable createAlias(String alias) {
    return $OrdersTableTable(_db, alias);
  }
}

class FactTableData extends DataClass implements Insertable<FactTableData> {
  final String id;
  final String orderId;
  final String date;
  final String salesmanId;
  final String productId;
  final String productName;
  final int quantity;
  final double unityPrice;
  final double totalPrice;
  FactTableData(
      {required this.id,
      required this.orderId,
      required this.date,
      required this.salesmanId,
      required this.productId,
      required this.productName,
      required this.quantity,
      required this.unityPrice,
      required this.totalPrice});
  factory FactTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FactTableData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      orderId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      date: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      salesmanId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}salesman_id'])!,
      productId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      productName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_name'])!,
      quantity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity'])!,
      unityPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unity_price'])!,
      totalPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_price'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['order_id'] = Variable<String>(orderId);
    map['date'] = Variable<String>(date);
    map['salesman_id'] = Variable<String>(salesmanId);
    map['product_id'] = Variable<String>(productId);
    map['product_name'] = Variable<String>(productName);
    map['quantity'] = Variable<int>(quantity);
    map['unity_price'] = Variable<double>(unityPrice);
    map['total_price'] = Variable<double>(totalPrice);
    return map;
  }

  FactTableCompanion toCompanion(bool nullToAbsent) {
    return FactTableCompanion(
      id: Value(id),
      orderId: Value(orderId),
      date: Value(date),
      salesmanId: Value(salesmanId),
      productId: Value(productId),
      productName: Value(productName),
      quantity: Value(quantity),
      unityPrice: Value(unityPrice),
      totalPrice: Value(totalPrice),
    );
  }

  factory FactTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FactTableData(
      id: serializer.fromJson<String>(json['id']),
      orderId: serializer.fromJson<String>(json['orderId']),
      date: serializer.fromJson<String>(json['date']),
      salesmanId: serializer.fromJson<String>(json['salesmanId']),
      productId: serializer.fromJson<String>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unityPrice: serializer.fromJson<double>(json['unityPrice']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'orderId': serializer.toJson<String>(orderId),
      'date': serializer.toJson<String>(date),
      'salesmanId': serializer.toJson<String>(salesmanId),
      'productId': serializer.toJson<String>(productId),
      'productName': serializer.toJson<String>(productName),
      'quantity': serializer.toJson<int>(quantity),
      'unityPrice': serializer.toJson<double>(unityPrice),
      'totalPrice': serializer.toJson<double>(totalPrice),
    };
  }

  FactTableData copyWith(
          {String? id,
          String? orderId,
          String? date,
          String? salesmanId,
          String? productId,
          String? productName,
          int? quantity,
          double? unityPrice,
          double? totalPrice}) =>
      FactTableData(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        date: date ?? this.date,
        salesmanId: salesmanId ?? this.salesmanId,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        quantity: quantity ?? this.quantity,
        unityPrice: unityPrice ?? this.unityPrice,
        totalPrice: totalPrice ?? this.totalPrice,
      );
  @override
  String toString() {
    return (StringBuffer('FactTableData(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('date: $date, ')
          ..write('salesmanId: $salesmanId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('unityPrice: $unityPrice, ')
          ..write('totalPrice: $totalPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          orderId.hashCode,
          $mrjc(
              date.hashCode,
              $mrjc(
                  salesmanId.hashCode,
                  $mrjc(
                      productId.hashCode,
                      $mrjc(
                          productName.hashCode,
                          $mrjc(
                              quantity.hashCode,
                              $mrjc(unityPrice.hashCode,
                                  totalPrice.hashCode)))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FactTableData &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.date == this.date &&
          other.salesmanId == this.salesmanId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.quantity == this.quantity &&
          other.unityPrice == this.unityPrice &&
          other.totalPrice == this.totalPrice);
}

class FactTableCompanion extends UpdateCompanion<FactTableData> {
  final Value<String> id;
  final Value<String> orderId;
  final Value<String> date;
  final Value<String> salesmanId;
  final Value<String> productId;
  final Value<String> productName;
  final Value<int> quantity;
  final Value<double> unityPrice;
  final Value<double> totalPrice;
  const FactTableCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.date = const Value.absent(),
    this.salesmanId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unityPrice = const Value.absent(),
    this.totalPrice = const Value.absent(),
  });
  FactTableCompanion.insert({
    this.id = const Value.absent(),
    required String orderId,
    required String date,
    required String salesmanId,
    required String productId,
    required String productName,
    required int quantity,
    required double unityPrice,
    required double totalPrice,
  })  : orderId = Value(orderId),
        date = Value(date),
        salesmanId = Value(salesmanId),
        productId = Value(productId),
        productName = Value(productName),
        quantity = Value(quantity),
        unityPrice = Value(unityPrice),
        totalPrice = Value(totalPrice);
  static Insertable<FactTableData> custom({
    Expression<String>? id,
    Expression<String>? orderId,
    Expression<String>? date,
    Expression<String>? salesmanId,
    Expression<String>? productId,
    Expression<String>? productName,
    Expression<int>? quantity,
    Expression<double>? unityPrice,
    Expression<double>? totalPrice,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (date != null) 'date': date,
      if (salesmanId != null) 'salesman_id': salesmanId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (quantity != null) 'quantity': quantity,
      if (unityPrice != null) 'unity_price': unityPrice,
      if (totalPrice != null) 'total_price': totalPrice,
    });
  }

  FactTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? orderId,
      Value<String>? date,
      Value<String>? salesmanId,
      Value<String>? productId,
      Value<String>? productName,
      Value<int>? quantity,
      Value<double>? unityPrice,
      Value<double>? totalPrice}) {
    return FactTableCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      date: date ?? this.date,
      salesmanId: salesmanId ?? this.salesmanId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unityPrice: unityPrice ?? this.unityPrice,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (salesmanId.present) {
      map['salesman_id'] = Variable<String>(salesmanId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unityPrice.present) {
      map['unity_price'] = Variable<double>(unityPrice.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FactTableCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('date: $date, ')
          ..write('salesmanId: $salesmanId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('unityPrice: $unityPrice, ')
          ..write('totalPrice: $totalPrice')
          ..write(')'))
        .toString();
  }
}

class $FactTableTable extends FactTable
    with TableInfo<$FactTableTable, FactTableData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $FactTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => _uuid.v1();
  }

  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedTextColumn orderId = _constructOrderId();
  GeneratedTextColumn _constructOrderId() {
    return GeneratedTextColumn(
      'order_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedTextColumn date = _constructDate();
  GeneratedTextColumn _constructDate() {
    return GeneratedTextColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _salesmanIdMeta = const VerificationMeta('salesmanId');
  @override
  late final GeneratedTextColumn salesmanId = _constructSalesmanId();
  GeneratedTextColumn _constructSalesmanId() {
    return GeneratedTextColumn(
      'salesman_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedTextColumn productId = _constructProductId();
  GeneratedTextColumn _constructProductId() {
    return GeneratedTextColumn(
      'product_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedTextColumn productName = _constructProductName();
  GeneratedTextColumn _constructProductName() {
    return GeneratedTextColumn(
      'product_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  @override
  late final GeneratedIntColumn quantity = _constructQuantity();
  GeneratedIntColumn _constructQuantity() {
    return GeneratedIntColumn(
      'quantity',
      $tableName,
      false,
    );
  }

  final VerificationMeta _unityPriceMeta = const VerificationMeta('unityPrice');
  @override
  late final GeneratedRealColumn unityPrice = _constructUnityPrice();
  GeneratedRealColumn _constructUnityPrice() {
    return GeneratedRealColumn(
      'unity_price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalPriceMeta = const VerificationMeta('totalPrice');
  @override
  late final GeneratedRealColumn totalPrice = _constructTotalPrice();
  GeneratedRealColumn _constructTotalPrice() {
    return GeneratedRealColumn(
      'total_price',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        orderId,
        date,
        salesmanId,
        productId,
        productName,
        quantity,
        unityPrice,
        totalPrice
      ];
  @override
  $FactTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'fact_table';
  @override
  final String actualTableName = 'fact_table';
  @override
  VerificationContext validateIntegrity(Insertable<FactTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('salesman_id')) {
      context.handle(
          _salesmanIdMeta,
          salesmanId.isAcceptableOrUnknown(
              data['salesman_id']!, _salesmanIdMeta));
    } else if (isInserting) {
      context.missing(_salesmanIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unity_price')) {
      context.handle(
          _unityPriceMeta,
          unityPrice.isAcceptableOrUnknown(
              data['unity_price']!, _unityPriceMeta));
    } else if (isInserting) {
      context.missing(_unityPriceMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price']!, _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  FactTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FactTableData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FactTableTable createAlias(String alias) {
    return $FactTableTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SalesmanTableTable salesmanTable = $SalesmanTableTable(this);
  late final $ProductsTableTable productsTable = $ProductsTableTable(this);
  late final $OrdersTableTable ordersTable = $OrdersTableTable(this);
  late final $FactTableTable factTable = $FactTableTable(this);
  late final SalesmanDao salesmanDao = SalesmanDao(this as AppDatabase);
  late final ProductsDao productsDao = ProductsDao(this as AppDatabase);
  late final FactTableDao factTableDao = FactTableDao(this as AppDatabase);
  late final OrdersTableDao ordersTableDao =
      OrdersTableDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [salesmanTable, productsTable, ordersTable, factTable];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$FactTableDaoMixin on DatabaseAccessor<AppDatabase> {
  $FactTableTable get factTable => attachedDatabase.factTable;
}
mixin _$OrdersTableDaoMixin on DatabaseAccessor<AppDatabase> {
  $OrdersTableTable get ordersTable => attachedDatabase.ordersTable;
  $FactTableTable get factTable => attachedDatabase.factTable;
}
mixin _$SalesmanDaoMixin on DatabaseAccessor<AppDatabase> {
  $SalesmanTableTable get salesmanTable => attachedDatabase.salesmanTable;
}
mixin _$ProductsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductsTableTable get productsTable => attachedDatabase.productsTable;
}
