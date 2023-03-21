import 'package:crypto_bot/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphView extends GetView<HomeController> {
  const GraphView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return RefreshIndicator(
        child: controller.loadingProfit.isTrue
            ? Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              )
            : SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: controller.tooltip,
                series: <ChartSeries>[
                  LineSeries<ChartData, String>(
                    dataSource: controller.data.value,
                    xValueMapper: (ChartData sales, _) => sales.x,
                    yValueMapper: (ChartData sales, _) => sales.y,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  )
                ],
              ),
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            controller.loadTodayAndTotalProfit();
          });
        },
      );
    });
  }
}
