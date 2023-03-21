import 'package:crypto_bot/app/data/coin_model.dart';
import 'package:crypto_bot/app/modules/home/controllers/home_controller.dart';
import 'package:crypto_bot/app/modules/home/widgets/dashboard_coin_item.dart';
import 'package:crypto_bot/app/modules/home/widgets/earning_views.dart';
import 'package:crypto_bot/app/modules/home/widgets/hero_button.dart';
import 'package:crypto_bot/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  Dashboard({
    super.key,
    required this.homeController,
  });
  HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Earnings',
                  style: GoogleFonts.firaSans(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlueAccent,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Bal: ',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Obx(() {
                        return Text(
                          homeController.remainingBalance.toStringAsFixed(2),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        );
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
          EarningView(
            homeController: homeController,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Coins',
                  style: GoogleFonts.firaSans(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.CREATE_COIN);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.lightBlueAccent,
                    ),
                  ),
                  child: Text('ADD COIN'),
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                homeController.getCoins();
                return Future.value();
              },
              child: Obx(
                () {
                  return homeController.isLoadingCoin.isTrue
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : homeController.isErrorCoinLoading.isTrue
                          ? Center(
                              child: Text(
                                homeController.errorMessage,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                CoinModel coinModel =
                                    homeController.coins[index];
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.COIN_DETAILS,
                                      arguments: coinModel,
                                    );
                                  },
                                  child: DashBoardCoinItem(
                                    coinModel: coinModel,
                                    homeController: homeController,
                                  ),
                                );
                              },
                              itemCount: homeController.coins.length,
                            );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
