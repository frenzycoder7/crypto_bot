import 'package:crypto_bot/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class EarningView extends StatelessWidget {
  EarningView({
    super.key,
    required this.homeController,
  });
  HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: InkWell(
                onTap: () {
                  homeController.loadTodayAndTotalProfit();
                },
                child: Material(
                  color: Colors.white,
                  elevation: 1,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Today\'s Profit',
                            style: GoogleFonts.aBeeZee(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Obx(() {
                            return homeController.loadingProfit.isTrue
                                ? const CircularProgressIndicator(
                                    color: Colors.greenAccent,
                                    strokeWidth: 1,
                                  )
                                : Text(
                                    '\$ ${num.parse(homeController.todayProfit.value.toString()).toDouble().toPrecision(2)}',
                                    style: const TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 20,
                                    ),
                                  );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: InkWell(
                onTap: () {
                  homeController.loadTodayAndTotalProfit();
                },
                child: Material(
                  color: Colors.white,
                  elevation: 1,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Total Profit',
                            style: GoogleFonts.aBeeZee(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Obx(() {
                            return homeController.loadingProfit.isTrue
                                ? const CircularProgressIndicator(
                                    color: Colors.greenAccent,
                                    strokeWidth: 1,
                                  )
                                : Text(
                                    '\$ ${num.parse(homeController.totalProfit.value.toString()).toDouble().toPrecision(2)}',
                                    style: const TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 20,
                                    ),
                                  );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
