class Order {
  String? sId;
  double? amount;
  double? buyPrice;
  double? sellPrice;
  String? symbol;
  String? status;
  String? createdAt;
  String? updatedAt;
  double? profit;
  int? leverage;
  double? marketSellPrice;
  int? tradeCount = 1;

  Order({
    this.sId,
    this.amount,
    this.buyPrice,
    this.sellPrice,
    this.symbol,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.profit,
    this.leverage,
    this.marketSellPrice = 0.0,
    this.tradeCount = 1,
  });

  Order.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    amount = json['amount'].runtimeType == int
        ? json['amount'].toDouble()
        : json['amount'];
    buyPrice = json['entryPrice'].runtimeType == int
        ? json['entryPrice'].toDouble()
        : json['entryPrice'];
    sellPrice = json['exitPrice'].runtimeType == int
        ? json['exitPrice'].toDouble()
        : json['exitPrice'];
    symbol = json['symbol'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profit = json['profit'].runtimeType == int
        ? json['profit'].toDouble()
        : json['profit'];
    leverage = json['leverage'];
    marketSellPrice = json['exitPrice'] == null
        ? 0.00
        : json['exitPrice'].runtimeType == int
            ? json['exitPrice'].toDouble()
            : json['exitPrice'];
    tradeCount = json['tradeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['amount'] = amount;
    data['buyPrice'] = buyPrice;
    data['sellPrice'] = sellPrice;
    data['symbol'] = symbol;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['profit'] = profit;
    return data;
  }
}
