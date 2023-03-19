import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/coin_details_controller.dart';

class CoinDetailsView extends GetView<CoinDetailsController> {
  const CoinDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Obx(() {
          return Text(
            controller.coinModel.value.symbol ?? 'NOT/FOUND',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          );
        }),
      ),
      body: Column(
        children: [
          Container(
            height: 40,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.isDeleting.isTrue) return;
          Get.dialog(
            AlertDialog(
              title: Text(
                'Warning !',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Are you sure you want to delete this coin ?',
                      style: GoogleFonts.firaCode(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.deleteCoin();
                    Get.back();
                  },
                  child: Text(
                    'Delete',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Obx(() {
          return controller.isDeleting.isTrue
              ? const CircularProgressIndicator()
              : const Icon(Icons.delete);
        }),
      ),
    );
  }
}
