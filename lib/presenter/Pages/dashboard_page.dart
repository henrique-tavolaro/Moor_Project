import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_bloc.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_event.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_state.dart';
import 'package:project/presenter/bloc/salesman_bloc/salesman_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<charts.Series<SalesBySalesmanResult, String>> series = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: StreamBuilder<List<SalesBySalesmanResult>>(
        stream: GetIt.I<FactBloc>().dao.salesBySalesman().watch(),
        builder: (context,
            AsyncSnapshot<List<SalesBySalesmanResult>>
            snapshot) {
          final list = snapshot.data ?? [];

          if (list.isNotEmpty){

            series.add(
                charts.Series(
                  id: 'Sales by Salesman',
                  data: list,
                  domainFn: (SalesBySalesmanResult sales, _) => sales.salesmanId,
                  measureFn: (SalesBySalesmanResult sales, _) => sales.count,
                )
            );

            return  Container(
              color: Colors.white,
              child: new charts.BarChart(
                series,
                animate: false,
              ),
            );

          }
          return Text('ssssss');

        },
      )
    );
  }
}
