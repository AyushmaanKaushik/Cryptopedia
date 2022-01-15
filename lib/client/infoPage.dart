import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({required this.cryptoName,required this.chartData});

  final String cryptoName;
  final List chartData;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cryptoName),),
      body: Container(
          height: MediaQuery.of(context).size.height/3,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <LineSeries<dynamic, String>>[
              LineSeries<dynamic, String>(
                dataSource: chartData,
                xValueMapper: (chartData, _)=>chartData[0].toString(),
                yValueMapper: (chartData, _)=>chartData[1],
              )
            ],
          ),
        ),
    );
  }
}
