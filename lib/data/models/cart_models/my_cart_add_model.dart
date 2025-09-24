class MyCartAddModel {
  final int productId, sizeId;

  MyCartAddModel({
    required this.productId,
    required this.sizeId,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "sizeId": sizeId,
    };
  }
}
