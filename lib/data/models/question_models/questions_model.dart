class QuestionsModel {
  final int id, order;
  final String title, answer;

  QuestionsModel({
    required this.id,
    required this.order,
    required this.title,
    required this.answer,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
      id: json["id"],
      order: json["order"],
      title: json["title"],
      answer: json["answer"],
    );
  }
}
