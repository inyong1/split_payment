import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:split_payment/app/modules/home/models/payment_split.dart';
import 'package:split_payment/app/modules/home/models/payment_type.dart';

class SplitPopupController extends GetxController {
  final double totalNominal;

  /// untuk menampung daftar split
  final splitListObs = <PaymentSplit>[].obs;
  final sisaObs = 0.0.obs;

  SplitPopupController(this.totalNominal);

  @override
  void onInit() {
    super.onInit();

    /// hanya kalau total > 0
    /// kita langsung split jadi dua
    if (totalNominal > 0) {
      splitListObs.addAll([
        PaymentSplit(
          id: (DateTime.now().microsecondsSinceEpoch + 1).toString(),
          paymentType: PaymentType.cash(),
          nominal: totalNominal / 2,
          textEditingController: TextEditingController(),
        ),
        PaymentSplit(
          id: (DateTime.now().microsecondsSinceEpoch + 2).toString(),
          paymentType: PaymentType.cash(),
          nominal: totalNominal / 2,
          textEditingController: TextEditingController(),
        ),
      ]);

      for (final split in splitListObs) {
        // split.textEditingController.addListener(() {
        //   if (split.textEditingController.text != split.nominal.toString()) {
        //     onNominalSplitChanged(split, split.textEditingController.text);
        //   }
        // });
        split.textEditingController.text = split.nominal.toString();
      }
    }
  }

  @override
  void onClose() {
    for (final p in splitListObs) {
      p.textEditingController.dispose();
    }
    super.onClose();
  }

  void onNominalSplitChanged(PaymentSplit split, String? value) {
    double newNominal = double.tryParse(value ?? '') ?? 0;

    /// cek ada tidak split lain yang belum pernah diedit
    /// dan sesuaikan nilainya jika ada
    List<PaymentSplit> editeds = splitListObs.where((s) {
      return s.id != split.id && s.edited;
    }).toList();

    List<PaymentSplit> unEditeds = splitListObs.where((s) {
      return s.id != split.id && !s.edited;
    }).toList();

    /// jika sudah diedit semua
    /// maka tindakan edit kali ini tidak boleh lebih dari total
    if (unEditeds.isEmpty) {
      double otherSplitTotal =
          editeds.fold<double>(0, (prev, e) => prev + e.nominal);
      double allowed = totalNominal - otherSplitTotal;
      if (newNominal > allowed) newNominal = allowed;
    } else {
      /// jumlakan dulu semu nilai yang sudah pernah diedit
      double totalEdited =
          newNominal + editeds.fold<double>(0, (prev, e) => prev + e.nominal);

      /// total nominal dikurangi total yang sudah diedit
      /// akan diberikan ke split yang belum pernah diedit
      double totalForUnEdited = totalNominal - totalEdited;

      for (final s in unEditeds) {
        ///setiap item split yang belum pernah diedit
        ///mendapat bagian yang sama
        if (totalForUnEdited > 0) {
          s.nominal = totalForUnEdited / unEditeds.length;
        } else {
          s.nominal = 0;
        }
        s.textEditingController.text = s.nominal.toString();
      }
    }
    split.nominal = newNominal;
    split.edited = true;

    final totalSplit = splitListObs.fold(0.0, (prev, e) => prev + e.nominal);
    sisaObs.value = totalNominal - totalSplit;
  }

  void onAddSplitButtonClick() {
    List<PaymentSplit> editeds = splitListObs.where((s) {
      return s.edited;
    }).toList();

    List<PaymentSplit> unEditeds = splitListObs.where((s) {
      return !s.edited;
    }).toList();

    final totalEdited = editeds.fold<double>(0, (prev, e) => prev + e.nominal);
    final forUnEdited = totalNominal - totalEdited;
    var newValue = 0.0;
    if (forUnEdited > 0) {
      newValue = forUnEdited / (unEditeds.length + 1);
    }
    for (final s in splitListObs) {
      if (!s.edited) {
        s.nominal = newValue;
        s.textEditingController.text = s.nominal.toString();
      }
    }
    final newSplit = PaymentSplit(
      textEditingController: TextEditingController(),
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      paymentType: PaymentType.cash(),
    );
    newSplit.nominal = newValue;
    newSplit.textEditingController.text = newSplit.nominal.toString();
    splitListObs.add(newSplit);
    final totalSplit = splitListObs.fold(0.0, (prev, e) => prev + e.nominal);
    sisaObs.value = totalNominal - totalSplit;
  }

  void onSaveButtonClick() {
    final totalSplit = splitListObs.fold(0.0, (prev, e) => prev + e.nominal);
    //todo: logic cek total Split == total nominal
    // ignore: invalid_use_of_protected_member
    Get.back(result: splitListObs.value);
  }

  void onItemDelete(PaymentSplit data) {
    splitListObs.removeWhere((element) => element.id == data.id);
    List<PaymentSplit> editeds = splitListObs.where((s) {
      return s.edited;
    }).toList();

    List<PaymentSplit> unEditeds = splitListObs.where((s) {
      return !s.edited;
    }).toList();

    final totalEdited = editeds.fold<double>(0, (prev, e) => prev + e.nominal);
    final forUnEdited = totalNominal - totalEdited;
    var newValue = 0.0;
    if (forUnEdited > 0) {
      newValue = forUnEdited / unEditeds.length;
    }
    for (final s in splitListObs) {
      if (!s.edited) {
        s.nominal = newValue;
        s.textEditingController.text = s.nominal.toString();
      }
    }
    final totalSplit = splitListObs.fold(0.0, (prev, e) => prev + e.nominal);
    sisaObs.value = totalNominal - totalSplit;
  }
}
