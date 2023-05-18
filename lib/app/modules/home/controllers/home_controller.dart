import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:split_payment/app/modules/home/models/payment_split.dart';
import 'package:split_payment/app/modules/home/views/split_popup_view.dart';

class HomeController extends GetxController {
  final totalTextController = TextEditingController();

  final paymentSplitListObs = <PaymentSplit>[].obs;

  @override
  void onClose() {
    totalTextController.dispose();
    super.onClose();
  }

  void onSplitPayementButtonClick() async {
    final double total = double.tryParse(totalTextController.text) ?? 0;
    if (total <= 0) {
      return;
    }
    final result = await Get.bottomSheet(
      SplitPopupView(totalNominal: total),
      isScrollControlled: true,
      backgroundColor: Colors.white,
    );

    if (result is List<PaymentSplit>) {
      paymentSplitListObs.value = result;
    }
  }
}
