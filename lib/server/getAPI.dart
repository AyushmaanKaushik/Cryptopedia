import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

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

Future<List> getCoinList() async {
  try {
    var url =
        "https://api.coingecko.com/api/v3/coins/bitcoin?developer_data=false&sparkline=false";
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    List info = [json['name'], json['description']['en'], json['homepage'][0]];
    print(info);
    return info;
  } catch (e) {
    print(e.toString());
    rethrow;
  }
}
