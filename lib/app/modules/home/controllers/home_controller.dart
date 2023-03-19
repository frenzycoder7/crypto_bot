// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names

import 'dart:convert';

import 'package:crypto_bot/app/data/coin_model.dart';
import 'package:crypto_bot/app/data/order_model.dart';
import 'package:crypto_bot/app/data/stream_ticker.dart';
import 'package:crypto_bot/config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetConnect implements GetxService {
  RxList<CoinModel> coins = <CoinModel>[].obs;
  RxMap<String, CoinModel> coinMap = <String, CoinModel>{}.obs;
  RxBool isLoadingCoin = false.obs;
  RxBool isErrorCoinLoading = false.obs;
  String errorMessage = '';
  RxBool loadingProfit = false.obs;
  RxDouble todayProfit = 0.0.obs;
  RxDouble totalProfit = 0.0.obs;

  RxString status = 'OPEN'.obs;
  RxInt pageSize = 10.obs;

  late PagingController<int, Order> pagingController;

  @override
  void onInit() {
    httpClient.baseUrl = AppConfig.baseUrl;
    super.onInit();
    getCoins();
    loadTodayAndTotalProfit();
    pagingController = PagingController(firstPageKey: 0);
    pagingController.addPageRequestListener((pageKey) {
      loadOpenOrders(pageKey: pageKey);
    });
    update_device_token();
  }

  void wsConnection() {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/!miniTicker@arr'),
    );
    channel.stream.listen((event) {
      filterTickerfromStream(json.decode(event));
    });
  }

  void update_device_token() async {
    String? token = await FirebaseMessaging.instance.getToken();
    try {
      Response response = await post('coin/update-token', {'token': token});
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Token updated successfully');
      } else {
        Fluttertoast.showToast(msg: 'Error while updating token');
        print('Error while updating token');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error while updating token');
      print('Error while updating token');
    }
  }

  filterTickerfromStream(List<dynamic> event) {
    for (var element in event) {
      StreamTicker ticker = StreamTicker.fromJson(element);
      if (coinMap[ticker.s] != null) {
        coinMap[ticker.s]!.marketPrice = ticker.c;
        coinMap[ticker.s]!.todayLow = ticker.l;
        coinMap[ticker.s]!.todayHigh = ticker.h;
        coinMap[ticker.s]!.isMarketPriceUp =
            double.parse(ticker.c as String) > double.parse(ticker.o as String);
        coinMap[ticker.s]!.marketPricePercent =
            ((double.parse(ticker.c as String) -
                        double.parse(ticker.o as String)) /
                    double.parse(ticker.o as String) *
                    100)
                .toStringAsFixed(2);
      }
    }

    coinMap.refresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getCoins() async {
    try {
      coins.clear();
      coinMap.clear();
      isErrorCoinLoading.value = false;
      isLoadingCoin.value = true;
      final Response response = await get('coin');
      if (response.statusCode == 200) {
        for (var coin in response.body['coins']) {
          CoinModel c = CoinModel.fromJson(coin);

          coins.add(c);
          coinMap[c.symbol as String] = c;
        }
        coinMap.refresh();
        coins.refresh();
        isLoadingCoin.value = false;
        Fluttertoast.showToast(msg: 'Coins fetched successfully');
        wsConnection();
      } else {
        errorMessage = response.body['message'];
        isLoadingCoin.value = false;
        isErrorCoinLoading.value = true;
        Fluttertoast.showToast(msg: 'Error while fetching coins');
      }
    } catch (e) {
      errorMessage = e.toString();
      isLoadingCoin.value = false;
      isErrorCoinLoading.value = true;
      Fluttertoast.showToast(msg: 'Network error while fetching coins');
    }
  }

  void loadTodayAndTotalProfit() async {
    try {
      loadingProfit.value = true;
      Response response = await get('coin/total');
      if (response.statusCode == 200) {
        if (response.body['data']['total'].runtimeType == 'int') {
          totalProfit.value = response.body['data']['total'].toDouble();
        } else {
          totalProfit.value = response.body['data']['total'];
        }
        DateTime now = DateTime.now();
        if (response.body['data']['data'][now.toString().split(' ').first] !=
            null) {
          todayProfit.value = response.body['data']['data']
              [now.toString().split(' ').first]['profit'];
        }
        loadingProfit.value = false;
      } else {
        loadingProfit.value = false;
        Fluttertoast.showToast(msg: 'Error while fetching profit');
      }
    } catch (e) {
      loadingProfit.value = false;
      print(e.toString());
      Fluttertoast.showToast(msg: 'Error while fetching profit');
    }
  }

  loadOpenOrders({required int pageKey}) async {
    try {
      int skip = pageKey ~/ pageSize.value;
      Response response =
          await get('coin/orders?limit=$pageSize&skip=$skip&status=$status');
      if (response.statusCode == 200) {
        List<Order> orders = [];
        for (var order in response.body['orders']) {
          orders.add(Order.fromJson(order));
        }
        final isLastPage = orders.length < pageSize.value;
        if (isLastPage) {
          pagingController.appendLastPage(orders);
        } else {
          final nextPageKey = pageKey + pageSize.value;
          pagingController.appendPage(orders, nextPageKey);
        }
      } else {
        pagingController.error = response.body['message'];
      }
    } catch (e) {
      pagingController.error = e.toString();
    }
  }

  setStatus({required String status}) {
    this.status.value = status;
    pagingController.refresh();
  }
}
