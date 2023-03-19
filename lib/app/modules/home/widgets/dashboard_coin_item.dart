import 'package:crypto_bot/app/data/coin_model.dart';
import 'package:crypto_bot/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardCoinItem extends StatelessWidget {
  DashBoardCoinItem({
    super.key,
    required this.coinModel,
    required this.homeController,
  });
  HomeController homeController;
  CoinModel coinModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${coinModel.symbol} × ${coinModel.leverage}',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Text(
                              homeController.coinMap[coinModel.symbol]!
                                          .marketPrice !=
                                      null
                                  ? double.parse(homeController
                                          .coinMap[coinModel.symbol]!
                                          .marketPrice as String)
                                      .toStringAsFixed(
                                      num.parse(homeController
                                              .coinMap[coinModel.symbol]!
                                              .precision
                                              .toString())
                                          .toInt(),
                                    )
                                  : '0.00',
                              style: GoogleFonts.poppins(
                                color: homeController.coinMap[coinModel.symbol]!
                                        .isMarketPriceUp
                                    ? Colors.green
                                    : Colors.grey,
                                fontSize: 15,
                              ),
                            );
                          }),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: coinModel.reorderOnSell == true
                                  ? Colors.greenAccent
                                  : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'ROS',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: coinModel.reorder == true
                                    ? Colors.greenAccent
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(5)),
                            alignment: Alignment.center,
                            child: const Text(
                              'ROB',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Obx(() {
                  return Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: homeController
                              .coinMap[coinModel.symbol]!.isMarketPriceUp
                          ? Colors.green.withOpacity(0.1)
                          : Colors.redAccent.withOpacity(0.1),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${homeController.coinMap[coinModel.symbol]!.marketPricePercent} %',
                      style: GoogleFonts.poppins(
                        color: homeController
                                .coinMap[coinModel.symbol]!.isMarketPriceUp
                            ? Colors.green
                            : Colors.redAccent,
                        fontSize: 16,
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
