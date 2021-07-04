import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:project/Theme/AppColors.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Add new product',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'product',
                    fillColor: Colors.white,
                    filled: true
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'price',
                      fillColor: Colors.white,
                      filled: true
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final product = ProductsTableCompanion.insert(
                      productName: nameController.text,
                      price: priceController.numberValue,
                    );
                    productsBloc.add(InsertProductEvent(product));
                  },
                  child: Text('Add product'),
                ),
              ),
              StreamB(),
            ],
          ),
        ),
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

        if(productsList.isNotEmpty){
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: productsList.length,
            itemBuilder: (_, index) {
              final product = productsList[index];
              return Card(
                elevation: 2,
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: CircleAvatar(
                    radius: 25,
                    child: Text(
                      '${product.productName[0].toUpperCase()}',
                      style: TextStyle(fontSize: 28),
                    ),
                    backgroundColor: AppColors.primaryDark,
                  ),
                  title: Text(
                    product.productName,
                    style: TextStyle(fontSize: 22),
                  ),
                  subtitle: Text(
                    '${product.price.toString()} \$CAD',
                    style: TextStyle(fontSize: 18),
                  ),

                ),
              );
            },
          );
        } else {
          return Text('No product registered');
        }

      },
    );
  }
}
