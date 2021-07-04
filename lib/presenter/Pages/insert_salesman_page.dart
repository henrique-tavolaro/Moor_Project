import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Theme/AppColors.dart';
import 'package:project/database/database.dart';
import 'package:project/domain/model/salesman.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_bloc.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_event.dart';

class InsertSalesmanPage extends StatefulWidget {
  const InsertSalesmanPage({Key? key}) : super(key: key);

  @override
  _InsertSalesmanPageState createState() => _InsertSalesmanPageState();
}

class _InsertSalesmanPageState extends State<InsertSalesmanPage> {
  late SalesmanBloc salesmanBloc;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController subsidiaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    salesmanBloc = BlocProvider.of<SalesmanBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Salesman'),
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
                  'Add new salesman',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Salesman name',
                  fillColor: Colors.white,
                  filled: true

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: subsidiaryController,
                  decoration: InputDecoration(
                    labelText: 'Subsidiary',
                      fillColor: Colors.white,
                      filled: true
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final salesman = SalesmanTableCompanion.insert(
                        name: nameController.text,
                        subsidiary: subsidiaryController.text,
                        );
                    salesmanBloc.add(InsertSalesmanEvent(salesman));
                  },
                  child: Text('Add salesman'),
                ),
              ),
              // BlocWidget()
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
    final bloc = BlocProvider.of<SalesmanBloc>(context).dao.watchAllSalesman();
    return StreamBuilder<List<SalesmanTableData>>(
      stream: bloc,
      builder: (context, AsyncSnapshot<List<SalesmanTableData>> snapshot) {
        final salesmanList = snapshot.data ?? [];

        if(salesmanList.isNotEmpty){
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: salesmanList.length,
            itemBuilder: (_, index) {
              final salesman = salesmanList[index];
              return Card(
                elevation: 2,
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: CircleAvatar(
                    radius: 25,
                    child: Text(
                      '${salesman.name[0]}',
                      style: TextStyle(fontSize: 28),
                    ),
                    backgroundColor: AppColors.primaryDark,
                  ),
                  title: Text(
                    salesman.name,
                    style: TextStyle(fontSize: 22),
                  ),
                  subtitle: Text(
                    salesman.subsidiary,
                    style: TextStyle(fontSize: 18),
                  ),

                ),
              );
            },
          );
        } else {
          return Text('No salesman registered');
        }
      },
    );
  }
}
