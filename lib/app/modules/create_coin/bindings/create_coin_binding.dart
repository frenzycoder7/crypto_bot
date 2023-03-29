import 'package:get/get.dart';

import '../controllers/create_coin_controller.dart';

class CreateCoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateCoinController());
  }
}
