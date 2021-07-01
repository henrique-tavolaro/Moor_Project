import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/bloc/product_bloc/product_bloc.dart';
import 'package:project/presenter/bloc/product_bloc/product_event.dart';

class InsertProductsPage extends StatefulWidget {
  const InsertProductsPage({Key? key}) : super(key: key);

  @override
  _InsertProductsPageState createState() => _InsertProductsPageState();
}

class _InsertProductsPageState extends State<InsertProductsPage> {
  late ProductsBloc productsBloc;
  final TextEditingController nameController = TextEditingController();
  final priceController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    rightSymbol: '\$CAD',
  );

  @override
  void initState() {
    super.initState();
    productsBloc = BlocProvider.of<ProductsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Products'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'product',
            ),
          ),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'price',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final product = ProductsTableCompanion.insert(
                productName: nameController.text,
                price: priceController.numberValue,
              );
              productsBloc.add(InsertProductEvent(product));
            },
            child: Text('Add product'),
          ),
          // BlocWidget()
          StreamB(),
        ],
      ),
    );
  }
}

class StreamB extends StatefulWidget {
  const StreamB({Key? key}) : super(key: key);

  @override
  _StreamBState createState() => _StreamBState();
}

class _StreamBState extends State<StreamB> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProductsBloc>(context).dao.watchAllProducts();
    return StreamBuilder<List<ProductsTableData>>(
      stream: bloc,
      builder: (context, AsyncSnapshot<List<ProductsTableData>> snapshot) {
        final productsList = snapshot.data ?? [];

        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: productsList.length,
          itemBuilder: (_, index) {
            final product = productsList[index];
            return Container(
              height: 30,
              child: ListTile(
                title: Text(product.productName),
              ),
            );
          },
        );
      },
    );
  }
}
