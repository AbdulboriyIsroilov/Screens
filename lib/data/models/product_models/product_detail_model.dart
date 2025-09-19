class ProductDetailModel {
  final int id;
  final String title;
  final String description;
  final int price;
  final bool isLiked;
  final List<MahsulotRasm> productImages;
  final List<MahsulotOlcham> productSizes;
  final int reviewsCount;
  final double rating;

  ProductDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.isLiked,
    required this.productImages,
    required this.productSizes,
    required this.reviewsCount,
    required this.rating,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      isLiked: json['isLiked'],
      productImages: (json['productImages'] as List).map((e) => MahsulotRasm.fromJson(e)).toList(),
      productSizes: (json['productSizes'] as List).map((e) => MahsulotOlcham.fromJson(e)).toList(),
      reviewsCount: json['reviewsCount'],
      rating: (json['rating'] as num).toDouble(),
    );
  }
}

class MahsulotRasm {
  final int id;
  final String image;

  MahsulotRasm({
    required this.id,
    required this.image,
  });

  factory MahsulotRasm.fromJson(Map<String, dynamic> json) {
    return MahsulotRasm(
      id: json['id'],
      image: json['image'],
    );
  }
}

class MahsulotOlcham {
  final int id;
  final String title;

  MahsulotOlcham({
    required this.id,
    required this.title,
  });

  factory MahsulotOlcham.fromJson(Map<String, dynamic> json) {
    return MahsulotOlcham(
      id: json['id'],
      title: json['title'],
    );
  }
}
