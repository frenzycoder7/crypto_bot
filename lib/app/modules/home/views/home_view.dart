import 'package:crypto_bot/app/modules/home/views/dashboard_view.dart';
import 'package:crypto_bot/app/modules/home/views/graph_view.dart';
import 'package:crypto_bot/app/modules/home/views/history_views.dart';
import 'package:crypto_bot/app/modules/home/views/open_orders_views.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage("assets/logo.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Crypto-bot',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage("assets/profile.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Image.asset(
                  "assets/home.png",
                  height: 25,
                  width: 25,
                ),
              ),
              Tab(
                child: Image.asset(
                  "assets/openorders.png",
                  height: 25,
                  width: 25,
                ),
              ),
              Tab(
                child: Image.asset(
                  "assets/graph.png",
                  height: 25,
                  width: 25,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Dashboard(
              homeController: controller,
            ),
            OpenOrderView(
              homeController: controller,
            ),
            GraphView(),
          ],
        ),
      ),
    );
  }
}
