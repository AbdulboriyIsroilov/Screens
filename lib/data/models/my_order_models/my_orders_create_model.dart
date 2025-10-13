class MyOrdersCreateModel {
  final int addressId, cardId;
  final String paymentMethod;

  MyOrdersCreateModel({
    required this.addressId,
    required this.cardId,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      "addressId": addressId,
      "cardId": cardId,
      "paymentMethod": paymentMethod,
    };
  }
}
