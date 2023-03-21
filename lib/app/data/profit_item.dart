class ProfitItem {
  double? profit;
  int? tc;

  ProfitItem({this.profit, this.tc});

  ProfitItem.fromJson(Map<String, dynamic> json) {
    profit = json['profit'];
    tc = json['tc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profit'] = profit;
    data['tc'] = tc;
    return data;
  }
}
