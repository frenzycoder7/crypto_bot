class CoinModel {
  String? sId;
  String? symbol;
  int? leverage;
  double? stopLossPercent;
  double? takeProfitPercent;
  bool? reorder;
  bool? useStopLoss;
  double? amount;
  double? reorderPercent;
  String? marketPrice;
  String? marketPricePercent;
  String? todayLow;
  String? todayHigh;
  bool isMarketPriceUp = false;
  int? precision;
  String? createdAt;
  bool? reorderOnSell;

  CoinModel({
    this.sId,
    this.symbol,
    this.leverage,
    this.stopLossPercent,
    this.takeProfitPercent,
    this.reorder,
    this.useStopLoss,
    this.amount,
    this.reorderPercent,
    this.precision,
    this.createdAt,
    this.marketPrice = '0.0',
    this.marketPricePercent = '0.0',
    this.isMarketPriceUp = false,
    this.todayLow = '0.0',
    this.todayHigh = '0.0',
    this.reorderOnSell = false,
  });

  CoinModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    symbol = json['symbol'];
    leverage = json['leverage'];
    stopLossPercent = json['stopLossPercent'].runtimeType == int
        ? json['stopLossPercent'].toDouble()
        : json['stopLossPercent'];

    takeProfitPercent = json['takeProfitPercent'].runtimeType == int
        ? json['takeProfitPercent'].toDouble()
        : json['takeProfitPercent'];
    reorder = json['reorder'];
    useStopLoss = json['useStopLoss'];
    amount = json['amount'].runtimeType == int
        ? json['amount'].toDouble()
        : json['amount'];
    reorderPercent = json['reorderPercent'].runtimeType == int
        ? json['reorderPercent'].toDouble()
        : json['reorderPercent'];
    precision = json['precision'];
    createdAt = json['createdAt'];
    reorderOnSell = json['reorderOnSell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['symbol'] = symbol;
    data['leverage'] = leverage;
    data['stopLossPercent'] = stopLossPercent;
    data['takeProfitPercent'] = takeProfitPercent;
    data['reorder'] = reorder;
    data['useStopLoss'] = useStopLoss;
    data['amount'] = amount;
    data['reorderPercent'] = reorderPercent;
    data['precision'] = precision;
    data['createdAt'] = createdAt;
    data['reorderOnSell'] = reorderOnSell;
    return data;
  }
}
