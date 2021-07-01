import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/model/fact.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_bloc.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_event.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_bloc.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_event.dart';
import 'package:uuid/uuid.dart';

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
  late OrdersBloc ordersBloc;
  late FactBloc factBloc;
  var uuid = Uuid().v4();

  @override
  void initState() {
    factBloc = BlocProvider.of<FactBloc>(context);
    ordersBloc = BlocProvider.of<OrdersBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: () {
          double totalCost = 0;
          final list = widget.factList;
          for (Fact i in list){
            totalCost = totalCost + i.totalPrice;

            final FactTableCompanion fact = FactTableCompanion.insert(
              totalPrice: i.totalPrice,
              productName: i.productName,
              unityPrice: i.unityPrice,
              productId: i.productId,
              salesmanId: '',
              date: widget.date!,
              orderId: uuid,
              quantity: i.quantity,
            );

            factBloc.add(InsertFactEvent(fact));
            }

          final OrdersTableData order = OrdersTableData(
            id: uuid,
            totalCost: totalCost,
          );

          ordersBloc.add(InsertOrdersEvent(order));

        }, child: Text('save order'),),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(widget.date != null ? widget.date! : 'no date selected'),
              Text(widget.salesman != null
                  ? widget.salesman!.name
                  : 'no salesman selected')
            ],
          ),
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
                      BottomDialogItem(fact: widget.factList[index])
                    ],
                  );
                }
                return BottomDialogItem(fact: widget.factList[index]);
              }
          ),
        ),
      ],
    );
  }
}

class BottomDialogHeader extends StatelessWidget {
  const BottomDialogHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Item'),
        Text('Quantity'),
        Text('total')
      ],
    );
  }
}

class BottomDialogItem extends StatelessWidget {
  final Fact fact;

  const BottomDialogItem({Key? key, required this.fact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(fact.productName),
        Text(fact.productName),
        Text(fact.totalPrice.toString()),
      ],
    );
  }
}
