
import 'package:flutter/material.dart';
import 'package:project/domain/model/fact.dart';

class BottomDialogItem extends StatefulWidget {
  final Fact fact;
  final List<Fact> factList;
  final VoidCallback onTap;

  const BottomDialogItem(
      {Key? key,
        required this.fact,
        required this.factList,
        required this.onTap})
      : super(key: key);

  @override
  _BottomDialogItemState createState() => _BottomDialogItemState();
}

class _BottomDialogItemState extends State<BottomDialogItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.fact.productName),
          Text(widget.fact.quantity.toString()),
          Text(widget.fact.totalPrice.toString()),
          GestureDetector(
            onTap: widget.onTap,
            child: Text(
              'remove',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}
