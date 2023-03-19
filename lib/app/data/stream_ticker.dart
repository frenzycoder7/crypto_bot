class StreamTicker {
  String? e;
  int? E;
  String? s;
  String? c;
  String? o;
  String? h;
  String? l;
  String? v;
  String? q;

  StreamTicker(
      {this.e, this.E, this.s, this.c, this.o, this.h, this.l, this.v, this.q});

  StreamTicker.fromJson(Map<String, dynamic> json) {
    e = json['e'];
    E = json['E'];
    s = json['s'];
    c = json['c'];
    o = json['o'];
    h = json['h'];
    l = json['l'];
    v = json['v'];
    q = json['q'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['e'] = e;
    data['E'] = E;
    data['s'] = s;
    data['c'] = c;
    data['o'] = o;
    data['h'] = h;
    data['l'] = l;
    data['v'] = v;
    data['q'] = q;
    return data;
  }
}
