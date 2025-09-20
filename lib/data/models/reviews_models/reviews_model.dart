class ReviewsModel {
  final int id, rating;
  final String comment, created, userFullName;

  ReviewsModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.created,
    required this.userFullName,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      id: json["id"],
      rating: json["rating"],
      comment: json["comment"],
      created: json["created"],
      userFullName: json["userFullName"],
    );
  }
}
