import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:project/database/database.dart';
import 'package:project/presenter/bloc/fact_bloc/fact_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  String month = DateFormat('MMMM').format(DateTime.now());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8),
            child: Text('Products share', style: TextStyle(color: Colors.white, fontSize: 16),),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<List<SalesByProductResult>>(
                  stream: GetIt
                      .I<FactBloc>()
                      .dao
                      .salesByProduct()
                      .watch(),
                  builder: (context,
                      AsyncSnapshot<List<SalesByProductResult>> snapshot) {
                    return pieGraph(snapshot);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('Sales in $month by salesman', style: TextStyle(color: Colors.white, fontSize: 16),),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<List<SalesBySalesmanResult>>(
                  stream: GetIt.I<FactBloc>().dao.salesBySalesman(month).watch(),
                  builder: (context, AsyncSnapshot<List<SalesBySalesmanResult>> snapshot){
                    return horizontalBarGraph(snapshot);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('Monthly total sales', style: TextStyle(color: Colors.white, fontSize: 16),),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<List<SalesByMonthResult>>(
                  stream: GetIt.I<FactBloc>().dao.salesByMonth().watch(),
                  builder: (context, AsyncSnapshot<List<SalesByMonthResult>> snapshot){
                    return verticalBarGraph(snapshot);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  StatelessWidget horizontalBarGraph(AsyncSnapshot<List<SalesBySalesmanResult>> snapshot) {
    final list = snapshot.data ?? [];
    if(list.isNotEmpty) {
      List<charts.Series<SalesBySalesmanResult, String>> series = [];
      series.add(charts.Series<SalesBySalesmanResult, String>(
        id: 'Sales by Salesman',
        data: list,
        domainFn: (SalesBySalesmanResult sales, _) => sales.firstName,
        measureFn: (SalesBySalesmanResult sales, _) => sales.totalPrice
      ));

      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: new charts.BarChart(
            series,
            animate: true,
            animationDuration: Duration(milliseconds: 800),
            vertical: false,
            barRendererDecorator: new charts.BarLabelDecorator<String>(),
            domainAxis:
            new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec())

        ),
      );
    }

    return Text('No data for this chart');
  }

  StatelessWidget verticalBarGraph(AsyncSnapshot<List<SalesByMonthResult>> snapshot) {
    final list = snapshot.data ?? [];
    if(list.isNotEmpty) {
      List<charts.Series<SalesByMonthResult, String>> series = [];
      series.add(charts.Series<SalesByMonthResult, String>(
        id: 'Sales by Month',
        data: list,
        domainFn: (SalesByMonthResult sales, _) => sales.month,
        measureFn: (SalesByMonthResult sales, _) => sales.sUMtotalPrice
      ));

      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: new charts.BarChart(
            series,
            animate: true,
          animationDuration: Duration(milliseconds: 800),
        ),
      );
    }

    return Text('No data for this chart');
  }

  StatelessWidget pieGraph(AsyncSnapshot<List<SalesByProductResult>> snapshot) {
    final list = snapshot.data ?? [];
    if (list.isNotEmpty) {
      List<charts.Series<SalesByProductResult, String>> series = [];
      series.add(charts.Series<SalesByProductResult, String>(
        id: 'Sales by Product',
        data: list,
        domainFn: (SalesByProductResult sales, _) => sales.productName,
        measureFn: (SalesByProductResult sales, _) => sales.sUMtotalPrice,
        labelAccessorFn: (SalesByProductResult sales, _) => sales.sUMtotalPrice.toString(),
      ));

      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: new charts.PieChart(
            series,
            animate: true,
            animationDuration: Duration(milliseconds: 800),
            behaviors: [
              new charts.DatumLegend(
                position: charts.BehaviorPosition.start,
                legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
                // horizontalFirst: false,
              )
            ],
            defaultRenderer: new charts.ArcRendererConfig(
                arcWidth: 60,
                arcRendererDecorators: [new charts.ArcLabelDecorator()])

        ),
      );
    }
    return Text('No data for this chart');
  }
}
