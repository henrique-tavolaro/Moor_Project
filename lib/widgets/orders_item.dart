import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/database/database.dart';

class OrderItem extends StatelessWidget {
  final OrdersTableData order;

  const OrderItem({Key? key, required this.order,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        children: [
          Text('Status'),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: order.status == 'Open' ? Colors.green : order.status == 'Closed' ? Colors.blue : Colors.red
              ),
              child: Text(order.status),
            ),
          )
        ],
      ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Date: ${order.date}'),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8),
        child: Text('Order id: ${order.id}'),
      ),
      trailing: Text('Total: \n${order.totalCost} \$CAD'),
    );
  }
}
