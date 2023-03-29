import 'package:crypto_bot/app/data/coin_model.dart';

class AppConfig {
  // static String baseUrl = 'https://api.crypto-bot.booringcodes.in/';
  // static String baseUrl = 'http://192.168.1.7:8001/';
  static String baseUrl = 'http://3.6.174.66:9432/';
}

class Args {
  bool create;
  CoinModel coinModel;

  Args({required this.create, required this.coinModel});
}
