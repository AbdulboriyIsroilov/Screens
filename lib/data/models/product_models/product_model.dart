class ProductModel {
  final int id, categoryId, price, discount;
  final String image, title;
  final bool isLiked;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.price,
    required this.discount,
    required this.image,
    required this.title,
    required this.isLiked,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      categoryId: json["categoryId"],
      price: json["price"],
      discount: json["discount"],
      image: json["image"],
      title: json["title"],
      isLiked: json["isLiked"],
    );
  }
}
