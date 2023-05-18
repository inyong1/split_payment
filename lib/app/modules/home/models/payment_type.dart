enum PaymentTypeEnum {
  cash,
  transfer,
}

class PaymentType {
  final String name;
  final PaymentTypeEnum typeEnum;
  const PaymentType._({
    required this.typeEnum,
    required this.name,
  });

  factory PaymentType.cash() {
    return const PaymentType._(typeEnum: PaymentTypeEnum.cash, name: "Cash");
  }

  factory PaymentType.transfer() {
    return const PaymentType._(
        typeEnum: PaymentTypeEnum.transfer, name: "Transfer");
  }
}
