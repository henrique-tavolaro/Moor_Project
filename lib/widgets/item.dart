import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
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
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.productName,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.product.price.toString()),
                    ),
                  ],
                ),
              ),
            ),
              Expanded(
                flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Container(
                  width: 30,
                  child: FloatingActionButton(
                    onPressed: () {
                      if(counter >0){
                        counter--;
                        setState(() {});
                      }
                    },
                    child: Text('-'),
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(counter.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                      width: 30,
                      child: FloatingActionButton(
                        onPressed: () {
                          counter++;
                          setState(() {});
                        },
                        child: Text('+'),
                      ),
                    ),
                  ),],
              ),
            ),

            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // width: 40,
                      child: Text(
                        counter == 0 ? '0.0' : totalPrice.toString(),
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    child: FloatingActionButton(
                      backgroundColor: Colors.green.shade800,
                      onPressed: () {
                        if(counter > 0){
                          final Fact fact = Fact(
                            productId: widget.product.id,
                            productName: widget.product.productName,
                            quantity: counter,
                            unityPrice: widget.product.price,
                            totalPrice: totalPrice,
                          );
                          widget.factList.add(fact);
                          final snackBar = SnackBar(content: Text('${widget.product.productName} added'), duration: Duration(seconds: 1),);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          counter = 0;
                          setState(() {});
                        }
                      },
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                  )
                ],
              ),
            )

            //
            // Container(
            //   width: 100,
            //   child: Text(
            //     widget.product.productName,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(widget.product.price.toString()),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0),
            //   child: Container(
            //     width: 30,
            //     child: FloatingActionButton(
            //       onPressed: () {
            //         if(counter >0){
            //           counter--;
            //           setState(() {});
            //         }
            //       },
            //       child: Text('-'),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(counter.toString()),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 16.0),
            //   child: Container(
            //     width: 30,
            //     child: FloatingActionButton(
            //       onPressed: () {
            //         counter++;
            //         setState(() {});
            //       },
            //       child: Text('+'),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     width: 40,
            //     child: Text(
            //       counter == 0 ? '0.0' : totalPrice.toString(),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: 30,
            //   child: FloatingActionButton(
            //     backgroundColor: Colors.green.shade800,
            //     onPressed: () {
            //       if(counter > 0){
            //         final Fact fact = Fact(
            //           productId: widget.product.id,
            //           productName: widget.product.productName,
            //           quantity: counter,
            //           unityPrice: widget.product.price,
            //           totalPrice: totalPrice,
            //         );
            //         widget.factList.add(fact);
            //         final snackBar = SnackBar(content: Text('${widget.product.productName} added'), duration: Duration(seconds: 1),);
            //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //         counter = 0;
            //         setState(() {});
            //       }
            //     },
            //     child: Icon(Icons.check, color: Colors.white),
            //   ),
            // )
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text('product')),
          Expanded(child: Text('Unit price')),

          Expanded(child: Text('Quantity')),

          Expanded(child: Text('Total \$CAD')),
        ],
      ),
    );
  }
}
