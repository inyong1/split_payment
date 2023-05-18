// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:split_payment/app/modules/home/models/payment_type.dart';

class PaymentSplit {
  final String id;
  double nominal;
  bool edited;
  PaymentType paymentType;
  TextEditingController textEditingController;
  PaymentSplit({
    required this.textEditingController,
    required this.id,
    this.nominal = 0.0,
    this.edited = false,
    required this.paymentType,
  });
}
