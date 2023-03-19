import 'package:crypto_bot/app/data/order_model.dart';
import 'package:crypto_bot/app/modules/home/controllers/home_controller.dart';
import 'package:crypto_bot/app/modules/home/views/PNL.dart';
import 'package:crypto_bot/app/modules/home/views/roe_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OpenOrderView extends StatelessWidget {
  OpenOrderView({
    super.key,
    required this.homeController,
  });
  HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50,
            color: Colors.white,
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: homeController.status.value == 'OPEN'
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          homeController.status.value == 'OPEN'
                              ? Colors.grey
                              : Colors.green.withOpacity(0.8),
                        ),
                      ),
                      onPressed: () {
                        if (homeController.status.value == 'OPEN') {
                          return;
                        } else {
                          homeController.setStatus(status: 'OPEN');
                        }
                      },
                      child: const Text('Open'),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: homeController.status.value == 'CLOSED'
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          homeController.status.value == 'CLOSED'
                              ? Colors.grey
                              : Colors.red.withOpacity(0.8),
                        ),
                      ),
                      onPressed: () {
                        if (homeController.status.value == 'CLOSED') {
                          return;
                        } else {
                          homeController.setStatus(status: 'CLOSED');
                        }
                      },
                      child: const Text('Closed'),
                    ),
                  ),
                ],
              );
            }),
          ),
          Expanded(
            child: PagedListView(
              pagingController: homeController.pagingController,
              builderDelegate: PagedChildBuilderDelegate<Order>(
                itemBuilder: (context, item, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.currency_bitcoin,
                                  color: Colors.greenAccent,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${item.symbol}',
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.grey.shade600,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Perpetual',
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.grey.shade600,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${item.leverage}x - ${homeController.status.value}',
                                  style: GoogleFonts.poppins(
                                    color: homeController.status.value == 'OPEN'
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'PNL (USDT) ',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      Obx(() {
                                        return homeController.status.value ==
                                                'CLOSED'
                                            ? Text(
                                                '${num.parse(
                                                  item.profit.toString(),
                                                ).toDouble().toPrecision(3)}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  color: Colors.grey.shade600,
                                                ),
                                              )
                                            : PnlWidget(
                                                entryPrice: double.parse(item
                                                        .buyPrice
                                                        .toString())
                                                    .toPrecision(homeController
                                                            .coinMap[
                                                                item.symbol]!
                                                            .precision ??
                                                        2),
                                                marketPrice: double.parse(
                                                        homeController
                                                            .coinMap[
                                                                item.symbol]!
                                                            .marketPrice
                                                            .toString())
                                                    .toPrecision(homeController
                                                            .coinMap[
                                                                item.symbol]!
                                                            .precision ??
                                                        2),
                                                qty: item.amount!.toDouble(),
                                              );
                                      })
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'ROE',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      Obx(() {
                                        return homeController.status.value ==
                                                'CLOSED'
                                            ? Text(
                                                '${((num.parse(item.profit.toString()) / ((num.parse(item.amount.toString()) * num.parse(item.buyPrice.toString())) / num.parse(item.leverage.toString()))) * 100).toDouble().toPrecision(2)} %')
                                            : ROEWidget(
                                                currentPrice: double.parse(
                                                        homeController
                                                            .coinMap[
                                                                item.symbol]!
                                                            .marketPrice
                                                            .toString())
                                                    .toPrecision(homeController
                                                            .coinMap[
                                                                item.symbol]!
                                                            .precision ??
                                                        2),
                                                entryPrice: double.parse(item
                                                        .buyPrice
                                                        .toString())
                                                    .toPrecision(homeController
                                                            .coinMap[
                                                                item.symbol]!
                                                            .precision ??
                                                        2),
                                                leverage: homeController
                                                    .coinMap[item.symbol]!
                                                    .leverage!
                                                    .toInt(),
                                                qty: item.amount!.toDouble(),
                                              );
                                      })
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Size (USDT)',
                                        style: GoogleFonts.firaSans(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${(num.parse(item.buyPrice.toString()) * num.parse(item.amount.toString())).toDouble().toPrecision(2)}',
                                        style: GoogleFonts.firaSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Margin (USDT)',
                                        style: GoogleFonts.firaSans(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${((num.parse(item.buyPrice.toString()) * num.parse(item.amount.toString())) / num.parse(item.leverage.toString())).toDouble().toPrecision(2)}',
                                        style: GoogleFonts.firaSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Coin Amount',
                                        style: GoogleFonts.firaSans(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${item.amount}',
                                        style: GoogleFonts.firaSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Entry Price',
                                        style: GoogleFonts.firaSans(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${item.buyPrice}',
                                        style: GoogleFonts.firaSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  homeController.status.value == 'CLOSED'
                                      ? Container()
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Market Price',
                                              style: GoogleFonts.firaSans(
                                                color: Colors.grey.shade600,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Obx(() {
                                              return Text(
                                                '${num.parse(homeController.coinMap[item.symbol]!.marketPrice.toString()).toDouble().toPrecision(homeController.coinMap[item.symbol]!.precision ?? 2)}',
                                                style: GoogleFonts.firaSans(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              );
                                            })
                                          ],
                                        ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Close Price',
                                        style: GoogleFonts.firaSans(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${item.marketSellPrice}',
                                        style: GoogleFonts.firaSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: homeController.status.value == 'OPEN'
                                    ? Text(
                                        DateTime.parse(
                                                item.createdAt.toString())
                                            .toLocal()
                                            .toString()
                                            .split('.')
                                            .first,
                                      )
                                    : Text(
                                        DateTime.parse(
                                                item.updatedAt.toString())
                                            .toLocal()
                                            .toString()
                                            .split('.')
                                            .first,
                                      ),
                              ),
                              Text('TC: ${item.tradeCount}'),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
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
