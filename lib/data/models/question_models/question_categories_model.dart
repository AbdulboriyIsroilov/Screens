class QuestionCategoriesModel {
  final int id, order;
  final String title;

  QuestionCategoriesModel({
    required this.id,
    required this.order,
    required this.title,
  });

  factory QuestionCategoriesModel.fromJson(Map<String, dynamic> json) {
    return QuestionCategoriesModel(
      id: json["id"],
      order: json["order"],
      title: json["title"],
    );
  }
}
