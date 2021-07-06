import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/database/database.dart';

class OrderSummary extends StatefulWidget {
  final OrderWithFacts orderWithFact;
  const OrderSummary({Key? key, required this.orderWithFact}) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.orderWithFact.fact.productName),
          Text(widget.orderWithFact.fact.quantity.toString()),
          Text(widget.orderWithFact.fact.totalPrice.toString()),
        ],
      ),
    );
  }
}

class OrderSummaryHeader extends StatefulWidget {
  final OrderWithFacts orderWithFacts;
  const OrderSummaryHeader({Key? key, required this.orderWithFacts}) : super(key: key);

  @override
  _OrderSummaryHeaderState createState() => _OrderSummaryHeaderState();
}

class _OrderSummaryHeaderState extends State<OrderSummaryHeader> {
  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: ${widget.orderWithFacts.order.totalCost} \$CAD'),
            Text('Date: ${dateFormat.format(widget.orderWithFacts.order.date)}'),
            Text('Status: ${widget.orderWithFacts.order.status}')
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Colors.black45,
          ),
        ),
        Padding(
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
            ],
          ),
        ),
      ],
    );
  }
}
