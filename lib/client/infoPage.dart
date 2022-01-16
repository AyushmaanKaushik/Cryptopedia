import 'package:crypto_watcher/server/getAPI.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../server/getAPI.dart';
import '../utilities/model.dart';

class InfoPage extends StatefulWidget {
  const InfoPage(
      {required this.info, required this.cryptoName, required this.chartData});

  final coinDetails info;
  final String cryptoName;
  final List chartData;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  coinDetails info = coinDetails(
      name: 'Error',
      symbol: 'error',
      description: 'No description',
      marketRank: 0,
      price: 0.0,
      image: 'img not found');

  @override
  void initState() {
    getInfo();
  }

  void getInfo() async {
    info = await getCoinInfo(widget.cryptoName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(info.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: CategoryAxis(title: AxisTitle(text: 'Price in \$')),
              series: <LineSeries<dynamic, String>>[
                LineSeries<dynamic, String>(
                  dataSource: widget.chartData,
                  xValueMapper: (chartData, _) => chartData[0].toString(),
                  yValueMapper: (chartData, _) => chartData[1],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(info.image),
                    const SizedBox(width: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          info.name,
                          style: const TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ),
                        Text(
                          info.symbol,
                          style:
                              const TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                TextElement(
                  title: 'Market Capital Rank: ',
                  nextTitle: info.marketRank.toString(),
                ),
                TextElement(
                    title: "Current Price: ",
                    nextTitle: '\$' + info.price.toString()),
                Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(info.description)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextElement extends StatelessWidget {
  const TextElement({required this.title, required this.nextTitle});

  final String title;
  final String nextTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.yellow, fontSize: 30),
        ),
        Text(
          nextTitle,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
