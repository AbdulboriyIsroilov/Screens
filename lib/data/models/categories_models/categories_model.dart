class CategoriesModel {
  final int id;
  final String title;

  CategoriesModel({
    required this.id,
    required this.title,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json["id"],
      title: json["title"],
    );
  }
}
