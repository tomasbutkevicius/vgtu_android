import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:math';

class FunctionView extends StatefulWidget {
  const FunctionView({Key? key, required this.listOfXValues}) : super(key: key);
  final List<double> listOfXValues;

  @override
  _FunctionViewState createState() => _FunctionViewState();
}

class _FunctionViewState extends State<FunctionView> {

  List<_Data> data = [];

  @override
  void initState() {
    for(double x in widget.listOfXValues){
      data.add(_Data(x.toString(), calculate(x)));
    }

    super.initState();
  }

    @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'cos(x) + x'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_Data, String>>[
                LineSeries<_Data, String>(
                    dataSource: data,
                    xValueMapper: (_Data sales, _) => sales.year,
                    yValueMapper: (_Data sales, _) => sales.sales,
                    name: 'value',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
        ]));
  }

  static double calculate(double x){
    return cos(x).toDouble() + x;
  }
}

class _Data {
  _Data(this.year, this.sales);

  final String year;
  final double sales;
}