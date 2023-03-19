import 'package:get/get.dart';

import '../controllers/coin_details_controller.dart';

class CoinDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoinDetailsController>(
      () => CoinDetailsController(),
    );
  }
}
