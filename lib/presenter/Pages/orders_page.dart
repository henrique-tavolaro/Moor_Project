import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project/database/database.dart';
import 'package:project/domain/model/fact.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_bloc.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_event.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_bloc.dart';
import 'package:project/presenter/bloc/product_bloc/product_bloc.dart';
import 'package:project/presenter/bloc/product_bloc/product_event.dart';
import 'package:project/presenter/bloc/product_bloc/product_state.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_bloc.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_event.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_state.dart';
import 'package:project/widgets/bottom_dialog.dart';
import 'package:project/widgets/item.dart';
import 'package:uuid/uuid.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late SalesmanBloc salesmanBloc;
  late ProductsBloc productsBloc;
  List<Fact> factList = [];

  late OrdersBloc ordersBloc;
  late FactBloc factBloc;

  @override
  void initState() {
    salesmanBloc = BlocProvider.of<SalesmanBloc>(context);
    salesmanBloc.add(GetAllSalesmanEvent());

    productsBloc = BlocProvider.of<ProductsBloc>(context);
    productsBloc.add(GetAllProductsEvent());


    factBloc = BlocProvider.of<FactBloc>(context);
    ordersBloc = BlocProvider.of<OrdersBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        actions: [
          IconButton(onPressed: () async {
            factBloc.add(GetAllFactsEvent());

          }, icon: Icon(Icons.add_chart))
        ],
        ),
      body: OrdersBody(factList: factList),
    );
  }
}

void ShowBottomDialog(
  BuildContext context,
  List<Fact> factList,
  String? date,
  SalesmanTableData? salesman,
) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomDialog(factList: factList, date: date, salesman: salesman);
      });
}





class OrdersBody extends StatefulWidget {
  const OrdersBody({Key? key, required this.factList}) : super(key: key);
  final List<Fact> factList;

  @override
  _OrdersBodyState createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  final dateController = TextEditingController();
  final _uuid = Uuid();
  SalesmanTableData? selectedSalesman;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                DateTime? datetime = (await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2030),
                ));
                var newdate = DateFormat('dd/MM/yyyy').format(datetime!);
                dateController.text = newdate.toString();
                setState(() {});
              },
              child: Text('pick date'),
            ),
            Text(
              dateController.text,
            ),
            ElevatedButton(
                onPressed: () => ShowBottomDialog(
                      context,
                      widget.factList,
                      dateController.text,
                      selectedSalesman
                    ),
                child: Text('order details'))
          ],
        ),
        BlocBuilder<SalesmanBloc, SalesmanStateBloc>(
          builder: (context, state) {
            if (state is GetSalesmanSuccessState) {
              final list = state.salesmanList;
              DropdownMenuItem<SalesmanTableData> dropdownFromSalesman(
                  SalesmanTableData salesman) {
                return DropdownMenuItem(
                  value: salesman,
                  child: Row(
                    children: <Widget>[
                      Text(salesman.name),
                    ],
                  ),
                );
              }

              final dropdownMenuItems = list
                  .map((salesman) => dropdownFromSalesman(salesman))
                  .toList()
                    ..insert(
                      0,
                      DropdownMenuItem(
                        value: null,
                        child: Text('No salesman'),
                      ),
                    );

              return DropdownButton(
                onChanged: (SalesmanTableData? tag) {
                  setState(() {
                    selectedSalesman = tag;
                  });
                },
                isExpanded: false,
                value: selectedSalesman,
                items: dropdownMenuItems,
              );
            } else {
              return Text('no salesman');
            }
          },
        ),
        SizedBox(
          height: 30,
        ),
        Card(
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is GetSuccessState) {
                final list = state.productsList;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          Header(),
                          Item(
                            product: list[index],
                            factList: widget.factList,
                          )
                        ],
                      );
                    }
                    return Item(
                      product: list[index],
                      factList: widget.factList,
                    );
                  },
                );
              } else {
                return Text('no products');
              }
            },
          ),
        ),
        StreamBu(),
        StreamBui(),

      ],
    );
  }
}

class StreamBu extends StatefulWidget {
  const StreamBu({Key? key}) : super(key: key);

  @override
  _StreamBuState createState() => _StreamBuState();
}

class _StreamBuState extends State<StreamBu> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FactBloc>(context).dao.watchAllFact();
    return StreamBuilder<List<FactTableData>>(
      stream: bloc,
      builder: (context, AsyncSnapshot<List<FactTableData>> snapshot) {
        final factList = snapshot.data ?? [];

        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: factList.length,
          itemBuilder: (_, index) {
            final fact = factList[index];
            return Container(
              height: 30,
              child: ListTile(
                title: Text('${fact.id.toString()}'),
              ),
            );
          },
        );
      },
    );
  }
}




class StreamBui extends StatefulWidget {
  const StreamBui({Key? key}) : super(key: key);

  @override
  _StreamBuiState createState() => _StreamBuiState();
}

class _StreamBuiState extends State<StreamBui> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<OrdersBloc>(context).dao.watchAllOrders();
    return StreamBuilder<List<OrdersTableData>>(
      stream: bloc,
      builder: (context, AsyncSnapshot<List<OrdersTableData>> snapshot) {
        final ordersList = snapshot.data ?? [];

        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: ordersList.length,
          itemBuilder: (_, index) {
            final order = ordersList[index];
            return Container(
              height: 30,
              child: ListTile(
                title: Text(order.id),
              ),
            );
          },
        );
      },
    );
  }
}