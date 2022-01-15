import 'package:crypto_watcher/client/infoPage.dart';
import 'package:flutter/material.dart';
import '../server/getAPI.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var coinList = [
    'bitcoin',
    'ethereum',
    'binancecoin',
    'tether',
    'solana',
    'usd-coin',
    'cardano',
    'ripple',
    'terra-luna',
    'polkadot',
    'dogecoin'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Watcher'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // child: Center(child: menuList(coinList)),
        child: ListView.builder(
            itemCount: coinList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(15),
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: TextButton(
                    child: Text(coinList[index]),
                    onPressed: () async {
                      List chartData = await getInfo(coinList[index]);
                      getCoinList();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InfoPage(
                                    cryptoName: coinList[index],
                                    chartData: chartData,
                                  )));
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}
