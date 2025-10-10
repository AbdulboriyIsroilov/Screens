class MyOrdersModel {
  final int id, price;
  final String title, image, size, status;
  final num? rating;

  MyOrdersModel({
    required this.id,
    required this.title,
    required this.image,
    required this.size,
    required this.price,
    required this.status,
    required this.rating,
  });

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) {
    return MyOrdersModel(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      size: json["size"],
      price: json["price"],
      status: json["status"],
      rating: json["rating"],
    );
  }
}
