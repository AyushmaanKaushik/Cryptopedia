class coin {
  late String name;
  late String id;

  coin({required this.name, required this.id});

  coin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
}

class coinDetails {
  late String name;
  late String symbol;
  // String algo, market rank, image;
  late int marketRank;
  late String image;
  late double price;
  late String description;

  coinDetails(
      {required this.name,
      required this.symbol,
      required this.description,
      required this.marketRank,
      required this.image,
      required this.price});
  coinDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    marketRank = json['market_cap_rank'];
    image = json["image"]["thumb"];
    price = json["market_data"]["current_price"]["usd"];
    description = json['description']['en'];
  }
}
