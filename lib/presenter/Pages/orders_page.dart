import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_bloc.dart';
import 'package:project/presenter/bloc/orders_bloc/orders_event.dart';
import 'package:project/widgets/order_summary.dart';
import 'package:project/widgets/orders_item.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String dropdownValue = OrderStatus.AllOrders.status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        actions: [
          DropdownButton(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>[
              OrderStatus.AllOrders.status,
              OrderStatus.Open.status,
              OrderStatus.Closed.status,
              OrderStatus.Canceled.status,
            ].map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              },
            ).toList(),
          )
        ],
      ),
      body: OrdersBody(
        dropdownValue: dropdownValue,
      ),
    );
  }
}

class OrdersBody extends StatefulWidget {
  final String dropdownValue;

  const OrdersBody({Key? key, required this.dropdownValue}) : super(key: key);

  @override
  _OrdersBodyState createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  final controller = ScrollController();
  String query = '';

  @override
  void initState() {
    GetIt.I<OrdersBloc>().add(GetAllOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: controller,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.maxFinite,
                child: Column(
                  children: [
                    StreamBuilder(
                        stream:
                            GetIt.I<OrdersBloc>().dao.getOrderWithFacts(query),
                        builder: (context,
                            AsyncSnapshot<List<OrderWithFacts>> snapshot) {
                          final list = snapshot.data ?? [];

                          if (list.isNotEmpty) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if (list[0].order.status != 'Open') {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'This order was ${list[0].order.status}',
                                                textColor: Colors.black,
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.white,
                                                timeInSecForIosWeb: 3);
                                          } else {
                                            final OrdersTableData order =
                                                OrdersTableData(
                                              id: list[0].order.id,
                                              status: 'Canceled',
                                              totalCost:
                                                  list[0].order.totalCost,
                                              date: list[0].order.date,
                                            );
                                            GetIt.I<OrdersBloc>()
                                                .add(UpdateOrderEvent(order));
                                            setState(() {});
                                            undoSnackbar(list, context);
                                          }
                                        },
                                        child: Text('Cancel Order'),
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                                list[0].order.status != 'Open'
                                                    ? Colors.grey
                                                    : Colors.red),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (list[0].order.status != 'Open') {
                                            Fluttertoast.showToast(
                                              msg:
                                                  'This order was ${list[0].order.status}',
                                              textColor: Colors.black,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.white,
                                              timeInSecForIosWeb: 3,
                                            );
                                          } else {
                                            final OrdersTableData order =
                                                OrdersTableData(
                                              id: list[0].order.id,
                                              status: 'Closed',
                                              totalCost:
                                                  list[0].order.totalCost,
                                              date: list[0].order.date,
                                            );
                                            GetIt.I<OrdersBloc>()
                                                .add(UpdateOrderEvent(order));
                                            setState(() {});
                                            undoSnackbar(list, context);
                                          }
                                        },
                                        child: Text('Close Order'),
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                                list[0].order.status != 'Open'
                                                    ? Colors.grey
                                                    : Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Column(
                                        children: [
                                          OrderSummaryHeader(
                                              orderWithFacts: list[0]),
                                          OrderSummary(
                                              orderWithFact: list[index])
                                        ],
                                      );
                                    }
                                    return OrderSummary(
                                        orderWithFact: list[index]);
                                  },
                                ),
                              ],
                              // ),
                            );
                          } else {
                            return Text('No order selected');
                          }
                        })
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              child: Container(
                width: double.maxFinite,
                child: StreamBuilder<List<OrdersTableData>>(
                  stream: widget.dropdownValue == 'All orders'
                      ? GetIt.I<OrdersBloc>().dao.watchAllOrders()
                      : widget.dropdownValue == 'Open'
                          ? GetIt.I<OrdersBloc>().dao.watchOpenOrders()
                          : widget.dropdownValue == 'Closed'
                              ? GetIt.I<OrdersBloc>().dao.watchClosedOrders()
                              : GetIt.I<OrdersBloc>().dao.watchCanceledOrders(),
                  builder:
                      (context, AsyncSnapshot<List<OrdersTableData>> snapshot) {
                    final ordersList = snapshot.data ?? [];

                    if (ordersList.isNotEmpty) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: ordersList.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              query = ordersList[index].id;
                              setState(() {});
                              print(query);
                              _scrollToTop();
                            },
                            child: OrderItem(
                              order: ordersList[index],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(64.0),
                          child: Text('No order registered'),
                        ),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void undoSnackbar(List<OrderWithFacts> list, BuildContext context) {
    final OrdersTableData orderUndo = OrdersTableData(
      id: list[0].order.id,
      status: 'Open',
      totalCost: list[0].order.totalCost,
      date: list[0].order.date,
    );
    final snackBar = SnackBar(
      content: Text('Order updated'),
      duration: Duration(seconds: 6),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          GetIt.I<OrdersBloc>().add(UpdateOrderEvent(orderUndo));
          setState(() {});
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _scrollToTop() {
    controller.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.fastLinearToSlowEaseIn);
  }
}

enum OrderStatus {
  Open,
  Closed,
  Canceled,
  AllOrders,
}

extension OrderStatusExtension on OrderStatus {
  String get name => describeEnum(this);

  String get status {
    switch (this) {
      case OrderStatus.Open:
        return 'Open';
      case OrderStatus.Closed:
        return 'Closed';
      case OrderStatus.Canceled:
        return 'Canceled';
      case OrderStatus.AllOrders:
        return 'All orders';
      default:
        return 'No status';
    }
  }
}



// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceAround,
//   children: [
//     ElevatedButton(onPressed: () async {
//     before = (await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(2021),
//           lastDate: DateTime(2030),
//         ))!;
//         print(before.toString());
//       }
//     , child: Text('BEFORE')),
//     ElevatedButton(onPressed: () async {
//       after = (await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2021),
//         lastDate: DateTime(2030),
//       ))!;
//       print(after.toString());
//     }, child: Text('AFTER'))
//   ],
// ),