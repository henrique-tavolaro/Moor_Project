import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:project/Theme/AppColors.dart';
import 'package:project/database/database.dart';
import 'package:project/domain/model/fact.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_bloc.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_bloc.dart';
import 'package:project/presenter/bloc/product_bloc/product_bloc.dart';
import 'package:project/presenter/bloc/product_bloc/product_event.dart';
import 'package:project/presenter/bloc/product_bloc/product_state.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_bloc.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_event.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_state.dart';
import 'package:project/widgets/bottom_dialog.dart';
import 'package:project/widgets/item.dart';
import 'package:project/widgets/register_orders_chips.dart';

class RegisterOrdersPage extends StatefulWidget {
  const RegisterOrdersPage({Key? key}) : super(key: key);

  @override
  _RegisterOrdersPageState createState() => _RegisterOrdersPageState();
}

class _RegisterOrdersPageState extends State<RegisterOrdersPage> {
  late SalesmanBloc salesmanBloc;
  late ProductsBloc productsBloc;
  late OrdersBloc ordersBloc;
  late FactBloc factBloc;
  List<Fact> factList = [];

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
        title: Text('Register Order'),
      ),
      body: RegisterOrdersBody(factList: factList),
    );
  }
}

class RegisterOrdersBody extends StatefulWidget {
  const RegisterOrdersBody({Key? key, required this.factList})
      : super(key: key);
  final List<Fact> factList;

  @override
  _RegisterOrdersBodyState createState() => _RegisterOrdersBodyState();
}

class _RegisterOrdersBodyState extends State<RegisterOrdersBody> {
  final dateController = TextEditingController();
  final now = DateTime.now();
  final dateFormat = DateFormat('dd/MM/yyyy');
  SalesmanTableData? selectedSalesman;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                String dateFormatted = await datePicker(context);
                                dateController.text = dateFormatted.toString();
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 16),
                                        child:
                                            Icon(Icons.calendar_today, size: 22),
                                      ),
                                      Text(
                                        dateController.text.isEmpty
                                            ? dateFormat.format(now)
                                            : dateController.text,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RegisterOrdersChips(
                            onTap: () {
                              if (selectedSalesman == null) {
                                toast('Select a salesman');
                              } else if (widget.factList.isEmpty) {
                                toast('Add a product to check the summary');
                              } else {
                                showBottomDialog(
                                    context,
                                    widget.factList,
                                    dateController.text.isEmpty
                                        ? dateFormat.format(now)
                                        : dateController.text,
                                    selectedSalesman);
                              }
                            },
                            text: 'Order Summary',
                            color: AppColors.secondary,
                          ),
                          BlocBuilder<SalesmanBloc, SalesmanStateBloc>(
                            builder: (context, state) {
                              if (state is GetSalesmanSuccessState) {
                                return salesmanDropdown(state);
                              } else {
                                return Text('no salesman');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                      physics: const NeverScrollableScrollPhysics(),
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
          ],
        ),
      ),
    );
  }

  Container salesmanDropdown(GetSalesmanSuccessState state) {
     final list = state.salesmanList;
    DropdownMenuItem<SalesmanTableData>
        dropdownFromSalesman(
            SalesmanTableData salesman) {
      return DropdownMenuItem(
        value: salesman,
        child: RegisterOrdersChips(
          text: salesman.name,
          color: Colors.white,
        ),
      );
    }
    
    final dropdownMenuItems = list
        .map((salesman) =>
            dropdownFromSalesman(salesman))
        .toList()
          ..insert(
            0,
            DropdownMenuItem(
              value: null,
              child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                  ),
                  child: Text('select salesman')),
            ),
          );
    
    return Container(
      width: 200,
      padding: EdgeInsets.only(right: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          onChanged: (SalesmanTableData? salesman) {
            setState(() {
              selectedSalesman = salesman;
            });
          },
          isExpanded: false,
          value: selectedSalesman,
          items: dropdownMenuItems,
        ),
      ),
    );
  }

  void toast(String message) {
      Fluttertoast.showToast(
        msg: message,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        timeInSecForIosWeb: 3);
  }

  Future<String> datePicker(BuildContext context) async {
    DateTime? datetime = (await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    ));
    var dateFormatted = dateFormat.format(datetime!);
    return dateFormatted;
  }
}

void showBottomDialog(
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
