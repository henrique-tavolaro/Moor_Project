import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';
import 'package:project/Theme/AppColors.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_bloc.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_event.dart';

class InsertSalesmanPage extends StatefulWidget {
  const InsertSalesmanPage({Key? key}) : super(key: key);

  @override
  _InsertSalesmanPageState createState() => _InsertSalesmanPageState();
}

class _InsertSalesmanPageState extends State<InsertSalesmanPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController subsidiaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Salesman'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
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
                        addSalesman();
                      },
                      child: Text('Add salesman'),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SalesmanList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addSalesman() {
    final salesman = SalesmanTableCompanion.insert(
      name: nameController.text,
      subsidiary: subsidiaryController.text,
    );
    GetIt.I<SalesmanBloc>().add(InsertSalesmanEvent(salesman));
    setState(() {});
    nameController.text = '';
    subsidiaryController.text = '';
  }
}

class SalesmanList extends StatefulWidget {
  const SalesmanList({Key? key}) : super(key: key);

  @override
  _SalesmanListState createState() => _SalesmanListState();
}

class _SalesmanListState extends State<SalesmanList> {
  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.I<SalesmanBloc>().dao.watchAllSalesman();
    return StreamBuilder<List<SalesmanTableData>>(

      stream: bloc,
      builder: (context, AsyncSnapshot<List<SalesmanTableData>> snapshot) {
        final salesmanList = snapshot.data ?? [];

        if(salesmanList.isNotEmpty){
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: salesmanList.length,
            itemBuilder: (_, index) {
              final salesman = salesmanList[index];
              return Dismissible(
                key: new Key(salesman.name),
                onDismissed: (direction){
                  GetIt.I<SalesmanBloc>().add(DeleteSalesmanEvent(salesman));
                },
                background: Container(color: Colors.red,),
                child: Card(
                  elevation: 2,
                  child: GestureDetector(
                    onTap: () {
                      print(salesman);
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      leading: CircleAvatar(
                        radius: 25,
                        child: Text(
                          '${salesman.name[0].toUpperCase()}',
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
