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
  var uuid = Uuid().v4();
  double totalCost = 0;
  final dateFormat = DateFormat('dd/MM/yyyy');
  final year = DateFormat('y');
  final monthName = DateFormat('MMMM');
  final monthNum = DateFormat('M');
  final day = DateFormat('d');

  initState(){
    initTotalCost();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);},
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      insertOrderAndFacts(context);
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
                    Text('Salesman: ${widget.salesman!.firstName}')
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
      ),
    );
  }

  void initTotalCost() {
    for (Fact i in widget.factList) {
      totalCost = totalCost + i.totalPrice;
    }
  }

  void insertOrderAndFacts(BuildContext context) {
      final list = widget.factList;
    for (Fact i in list) {
      final FactTableCompanion fact = FactTableCompanion.insert(
        totalPrice: i.totalPrice,
        productName: i.productName,
        unityPrice: i.unityPrice,
        productId: i.productId,
        salesmanId: widget.salesman!.id,
        date: dateFormat.parse(widget.date!),
        year: year.format(dateFormat.parse(widget.date!)).toString(),
        month: monthName.format(dateFormat.parse(widget.date!)).toString(),
        monthNum: int.parse(monthNum.format(dateFormat.parse(widget.date!))),
        day: day.format(dateFormat.parse(widget.date!)).toString(),
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
