import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../utilities/model.dart';

Future<List<dynamic>> getInfo(String coinName) async {
  try {
    int days = 31;
    var url =
        "https://api.coingecko.com/api/v3/coins/$coinName/market_chart?vs_currency=usd&days=$days&interval=daily";
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var chartData = json['prices'];
    for (int i = 0; i <= days; i++) {
      var temp = json['prices'][i][0];
      //Convert unix timestamp to a date format
      var date = DateTime.fromMicrosecondsSinceEpoch(temp * 1000);
      //assign the yyyy-mm-dd format of a date to the list
      chartData[i][0] = date.toString().substring(0, 10);
    }
    return chartData;
  } catch (e) {
    throw (e.toString());
  }
}

Future<List<coin>> getCoinList() async {
  try {
    var url =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false";
    var response = await http.get(Uri.parse(url));
    var coins = <coin>[];
    var json = jsonDecode(response.body);
    for (var coinList in json) {
      coins.add(coin.fromJson(coinList));
    }
    return coins;
  } catch (e) {
    print(e.toString());
    rethrow;
  }
}

Future<coinDetails> getCoinInfo(String coin) async {
  try {
    var url =
        "https://api.coingecko.com/api/v3/coins/$coin?localization=false&tickers=false&developer_data=false&sparkline=false";
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    coinDetails info = coinDetails.fromJson(json);
    return info;
  } catch (e) {
    print(e.toString());
    throw e;
  }
}
