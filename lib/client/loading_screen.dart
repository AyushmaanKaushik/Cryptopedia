import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utilities/model.dart';
import '../server/getAPI.dart';
import 'infoPage.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({required this.cryptoName});
  String cryptoName;
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadCoinInfo();
  }

  void loadCoinInfo() async {
    coinDetails info = await getCoinInfo(widget.cryptoName);
    List chartData = await getInfo(widget.cryptoName);
    List<ChartData> ohlcData = await getChartData(widget.cryptoName);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InfoPage(
                  info: info,
                  cryptoName: widget.cryptoName,
                  chartData: chartData,
                  ohlcData: ohlcData,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitPianoWave(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
