import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:project/domain/model/fact.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_bloc.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_event.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_bloc.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_event.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_state.dart';
import 'package:uuid/uuid.dart';

import 'bottom_dialog_item.dart';

class BottomDialog extends StatefulWidget {
  final List<Fact> factList;
  final String? date;
  final SalesmanTableData? salesman;

  const BottomDialog(
      {Key? key, required this.factList, this.date, this.salesman})
      : super(key: key);

  @override
  _BottomDialogState createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {
  // late OrdersBloc ordersBloc;
  // late FactBloc factBloc;
  var uuid = Uuid().v4();
  double totalCost = 0;
  final dateFormat = DateFormat('dd/MM/yyyy');

  // @override
  // void initState() {
  //   factBloc = BlocProvider.of<FactBloc>(context);
  //   ordersBloc = BlocProvider.of<OrdersBloc>(context);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    for (Fact i in widget.factList) {
      totalCost = totalCost + i.totalPrice;
    }
    return
      // BlocListener<OrdersBloc, OrdersState>(
      // listener: (context, state){
      //   if(state is InsertSuccessState) {
      //     final snackBar = SnackBar(content: Text('Order registered'), duration: Duration(seconds: 1),);
      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //   }
      // },
      // child:
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(

                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final list = widget.factList;
                    for (Fact i in list) {
                      final FactTableCompanion fact = FactTableCompanion.insert(
                        totalPrice: i.totalPrice,
                        productName: i.productName,
                        unityPrice: i.unityPrice,
                        productId: i.productId,
                        salesmanId: widget.salesman!.id,
                        date: dateFormat.parse(widget.date!),
                        orderId: uuid,
                        quantity: i.quantity,
                      );

                      GetIt.I<FactBloc>().add(InsertFactEvent(fact));
                    }

                    final OrdersTableData order = OrdersTableData(
                      id: uuid,
                      totalCost: totalCost,
                      status: 'Open',
                      date: dateFormat.parse(widget.date!),

                    );

                    GetIt.I<OrdersBloc>().add(InsertOrdersEvent(order));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('save order'),
                ),
                Text(
                    'Total: $totalCost \$CAD'
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date: ${widget.date!}'),
                  Text('Salesman: ${widget.salesman!.name}')
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black45,
            ),
            Container(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.factList.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          BottomDialogHeader(),
                          BottomDialogItem(
                            fact: widget.factList[index],
                            factList: widget.factList,
                            onTap: () {
                              widget.factList.removeAt(index);
                              totalCost = 0;
                              setState(() {});
                            },
                          )
                        ],
                      );
                    }
                    return BottomDialogItem(
                      fact: widget.factList[index],
                      factList: widget.factList,
                      onTap: () {
                        widget.factList.removeAt(index);
                        totalCost = 0;
                        setState(() {});
                      },
                    );
                  },
              ),
            ),
          ],
        ),
      // ),
    );
  }
}

class BottomDialogHeader extends StatelessWidget {
  const BottomDialogHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Item',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          Text(
            'Quantity',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          Text(
            'total',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          Text(
            'remove',
            style: TextStyle(color: Colors.transparent),
          )
        ],
      ),
    );
  }
}
