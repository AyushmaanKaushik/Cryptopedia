import 'package:crypto_watcher/client/infoPage.dart';
import 'package:crypto_watcher/utilities/model.dart';
import 'package:flutter/material.dart';
import '../server/getAPI.dart';
import 'dart:convert';
import '../utilities/model.dart';
import 'loading_screen.dart';
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var coinList = [
  //   'bitcoin',
  //   'ethereum',
  //   'binancecoin',
  //   'tether',
  //   'solana',
  //   'usd-coin',
  //   'cardano',
  //   'ripple',
  //   'terra-luna',
  //   'polkadot',
  //   'dogecoin'
  // ];

  List<coin> _coins = <coin>[];

  @override
  void initState() {
    super.initState();
    getValues();
  }

  getValues() async {
    _coins = await getCoinList();
    setState(() {});
  }

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
            itemCount: _coins.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: TextButton(
                    child: Text(_coins[index].name, style: const TextStyle(fontSize: 20),),
                    onPressed: () async {
                      List chartData = await getInfo(_coins[index].id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadingScreen(
                                    cryptoName: _coins[index].id,
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
