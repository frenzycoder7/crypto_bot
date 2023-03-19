import 'package:crypto_bot/app/data/coin_model.dart';
import 'package:crypto_bot/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CoinDetailsController extends GetConnect implements GetxService {
  Rx<CoinModel> coinModel = CoinModel().obs;
  RxBool isDeleting = false.obs;

  @override
  void onInit() {
    coinModel.value = Get.arguments;
    httpClient.baseUrl = AppConfig.baseUrl;
    super.onInit();
  }

  loadTradeHistory() async {}

  deleteCoin() async {
    try {
      isDeleting.value = true;
      Response response = await delete('coin/${coinModel.value.symbol}');
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Coin deleted successfully');
        Get.back();
      } else {
        Fluttertoast.showToast(msg: response.body['message']);
      }
      isDeleting.value = false;
    } catch (e) {
      isDeleting.value = false;
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }
}
