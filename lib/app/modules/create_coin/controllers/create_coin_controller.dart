import 'dart:convert';

import 'package:crypto_bot/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CreateCoinController extends GetxController {
  TextEditingController coinNameController = TextEditingController();
  TextEditingController coinAmount = TextEditingController();
  RxInt leverage = 1.obs;
  RxInt precision = 1.obs;
  RxBool reorderOnSell = false.obs;
  RxBool reorderOnBuy = false.obs;
  RxInt sellPercentage = 1.obs;
  RxInt buyPercentage = 1.obs;
  RxInt maxTrade = 1.obs;
  RxBool oomp = false.obs;
  RxBool isDeleting = false.obs;

  RxBool isCreating = false.obs;
  RxString name = ''.obs;
  RxBool editMode = false.obs;

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

  increaseMaxTrade() {
    maxTrade.value++;
  }

  decreaseMaxTrade() {
    if (maxTrade.value > -1) {
      maxTrade.value--;
    } else {
      Fluttertoast.showToast(msg: 'Max Trade cannot be less than 1');
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
    Args args = Get.arguments as Args;
    if (args.create == true) {
      name.value = 'CREATE COIN';
    } else {
      editMode.value = true;
      name.value = 'EDIT COIN ${args.coinModel.symbol}';
      coinNameController.text = args.coinModel.symbol as String;
      coinAmount.text = args.coinModel.amount.toString();
      leverage.value = args.coinModel.leverage as int;
      precision.value = args.coinModel.precision as int;
      sellPercentage.value = args.coinModel.takeProfitPercent!.toInt();
      reorderOnBuy.value = args.coinModel.reorder as bool;
      buyPercentage.value = args.coinModel.reorderPercent!.toInt();
      reorderOnSell.value = args.coinModel.reorderOnSell as bool;
      oomp.value = args.coinModel.buyOnMarketAfterSell as bool;
      maxTrade.value = args.coinModel.maxTrade as int;
    }
  }

  @override
  void onClose() {
    super.onClose();
    print('Disposing');
    dispose();
  }

  @override
  void onReady() {
    super.onReady();
    print('Ready');
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
        'leverage': leverage.value.toString(),
        'precision': precision.value.toString(),
        'takeProfitPercent': sellPercentage.value.toString(),
        'reorder': reorderOnBuy.value.toString(),
        'reorderPercent': buyPercentage.value.toString(),
        'reorderOnSell': reorderOnSell.value.toString(),
        'buyOnMarketAfterSell': oomp.value.toString(),
        'maxTrade': maxTrade.value.toString(),
      };
      if (editMode.isTrue) {
        body.remove('symbol');
      }
      http.Response res = editMode.isTrue
          ? await http.patch(
              Uri.parse(
                '${AppConfig.baseUrl}coin/${coinNameController.text}',
              ),
              body: body,
            )
          : await http.post(Uri.parse('${AppConfig.baseUrl}coin'), body: body);
      var response = json.decode(res.body);
      if (res.statusCode == 201) {
        coinNameController.clear();
        coinAmount.clear();
        leverage.value = 1;
        precision.value = 1;
        sellPercentage.value = 1;
        Fluttertoast.showToast(msg: 'Coin created');
      } else {
        Fluttertoast.showToast(msg: response['message']);
      }
      isCreating.value = false;
    } catch (e) {
      print(e);
      isCreating.value = false;
      Fluttertoast.showToast(msg: 'Error creating coin');
    }
  }

  deleteCoin() async {
    try {
      isDeleting.value = true;
      http.Response response = await http.delete(
        Uri.parse('${AppConfig.baseUrl}coin/${coinNameController.text}'),
      );
      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Coin deleted successfully');
        Get.back();
      } else {
        Fluttertoast.showToast(msg: res['message']);
      }
      isDeleting.value = false;
    } catch (e) {
      isDeleting.value = false;
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }
}
