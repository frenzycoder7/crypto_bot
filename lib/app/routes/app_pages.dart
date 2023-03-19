import 'package:get/get.dart';

import '../modules/coin_details/bindings/coin_details_binding.dart';
import '../modules/coin_details/views/coin_details_view.dart';
import '../modules/create_coin/bindings/create_coin_binding.dart';
import '../modules/create_coin/views/create_coin_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_COIN,
      page: () => const CreateCoinView(),
      binding: CreateCoinBinding(),
    ),
    GetPage(
      name: _Paths.COIN_DETAILS,
      page: () => const CoinDetailsView(),
      binding: CoinDetailsBinding(),
    ),
  ];
}
