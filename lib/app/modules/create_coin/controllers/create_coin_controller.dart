import 'package:crypto_bot/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CreateCoinController extends GetConnect implements GetxService {
  TextEditingController coinNameController = TextEditingController();
  TextEditingController coinAmount = TextEditingController();
  RxInt leverage = 1.obs;
  RxInt precision = 1.obs;
  RxBool reorderOnSell = false.obs;
  RxBool reorderOnBuy = false.obs;
  RxInt sellPercentage = 1.obs;
  RxInt buyPercentage = 1.obs;

  RxBool isCreating = false.obs;

  increaseLeverage() {
    leverage.value++;
  }

  decreaseLeverage() {
    if (leverage.value > 1) {
      leverage.value--;
    } else {
      Fluttertoast.showToast(msg: 'Leverage cannot be less than 1');
    }
  }

  increaseSellPercentage() {
    if (sellPercentage.value < 100) {
      sellPercentage.value++;
    } else {
      Fluttertoast.showToast(msg: 'Sell Percentage cannot be more than 100');
    }
  }

  decreaseSellPercentage() {
    if (sellPercentage.value > 1) {
      sellPercentage.value--;
    } else {
      Fluttertoast.showToast(msg: 'Sell Percentage cannot be less than 1');
    }
  }

  increaseBuyPercentage() {
    if (buyPercentage.value < 100) {
      buyPercentage.value++;
    } else {
      Fluttertoast.showToast(msg: 'Buy Percentage cannot be more than 100');
    }
  }

  decreaseBuyPercentage() {
    if (buyPercentage.value > 1) {
      buyPercentage.value--;
    } else {
      Fluttertoast.showToast(msg: 'Buy Percentage cannot be less than 1');
    }
  }

  increasePrecision() {
    precision.value++;
  }

  decreasePrecision() {
    if (precision.value > 1) {
      precision.value--;
    } else {
      Fluttertoast.showToast(msg: 'Precision cannot be less than 1');
    }
  }

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = AppConfig.baseUrl;
  }

  void createdCoin() async {
    if (coinNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Coin Name cannot be empty');
      return;
    } else if (coinAmount.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Coin Amount cannot be empty');
      return;
    }

    try {
      isCreating.value = true;
      Map<String, dynamic> body = {
        'symbol': coinNameController.text,
        'amount': coinAmount.text,
        'leverage': leverage.value,
        'precision': precision.value,
        'takeProfitPercent': sellPercentage.value,
        'reorder': reorderOnBuy.value,
        'reorderPercent': buyPercentage.value,
        'reorderOnSell': reorderOnSell.value,
      };
      Response response = await post('coin', body);
      if (response.statusCode == 201) {
        coinNameController.clear();
        coinAmount.clear();
        leverage.value = 1;
        precision.value = 1;
        sellPercentage.value = 1;
        Fluttertoast.showToast(msg: 'Coin created');
      } else {
        Fluttertoast.showToast(msg: response.body['message']);
      }
      isCreating.value = false;
    } catch (e) {
      isCreating.value = false;
      Fluttertoast.showToast(msg: 'Error creating coin');
    }
  }
}
