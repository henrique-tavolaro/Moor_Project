import 'package:flutter/material.dart';
import 'package:project/database/database.dart';
import 'package:project/domain/model/fact.dart';

class Item extends StatefulWidget {
  final ProductsTableData product;
  final List<Fact> factList;
  const Item({
    Key? key,
    required this.product, required this.factList,
  }) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    var totalPrice = widget.product.price * counter;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: 10,
                child: Text(
                  widget.product.productName,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.price.toString()),
            ),
            Container(
              width: 30,
              child: FloatingActionButton(
                onPressed: () {
                  counter--;
                  setState(() {});
                },
                child: Text('-'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(counter.toString()),
            ),
            Container(
              width: 30,
              child: FloatingActionButton(
                onPressed: () {
                  counter++;
                  setState(() {});
                },
                child: Text('+'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                counter == 0 ? 'R\$ 0' : totalPrice.toString(),
              ),
            ),
            Container(
              width: 30,
              child: FloatingActionButton(
                backgroundColor: Colors.green.shade800,
                onPressed: () {
                  final Fact fact = Fact(
                      productId: widget.product.id,
                      productName: widget.product.productName,
                      quantity: counter,
                      unityPrice: widget.product.price,
                      totalPrice: totalPrice,
                  );
                  widget.factList.add(fact);
                  print(fact.totalPrice.toString());
                },
                child: Icon(Icons.check, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 100,
            child: Text('product'),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            width: 60,
            child: Text('Unit price'),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 55,
            child: Text('Quantity'),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            width: 80,
            child: Text('Total'),
          ),
        ],
      ),
    );
  }
}
