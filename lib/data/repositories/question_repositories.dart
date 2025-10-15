import 'package:screens/core/client.dart';
import 'package:screens/data/models/question_models/question_categories_model.dart';
import 'package:screens/data/models/question_models/questions_model.dart';

import '../../core/utils/result.dart';

class QuestionRepositories {
  QuestionRepositories({
    required ApiClient client,
  }) : _client = client;
  final ApiClient _client;

  Future<Result<List<QuestionsModel>>> getQuestion() async {
    var response = await _client.get<List>("/questions");
    return response.fold(
      (error) => Result.error(error),
      (value) => Result.ok(value.map((item) => QuestionsModel.fromJson(item)).toList()),
    );
  }

  Future<Result<List<QuestionCategoriesModel>>> getQuestionCategories() async {
    var response = await _client.get<List>("/question-categories");
    return response.fold(
      (error) => Result.error(error),
      (value) => Result.ok(value.map((item) => QuestionCategoriesModel.fromJson(item)).toList()),
    );
  }
}
