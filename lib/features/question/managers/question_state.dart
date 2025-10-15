import 'package:equatable/equatable.dart';
import 'package:screens/core/utils/enum_state.dart';
import 'package:screens/data/models/question_models/question_categories_model.dart';
import 'package:screens/data/models/question_models/questions_model.dart';

class QuestionState extends Equatable {
  final String? errorMessage;
  final List<QuestionsModel> question;
  final List<QuestionCategoriesModel> questionCategories;
  final EnumState questionEnum;

  const QuestionState({
    required this.errorMessage,
    required this.question,
    required this.questionCategories,
    required this.questionEnum,
  });

  factory QuestionState.initial() => const QuestionState(
    errorMessage: null,
    question: [],
    questionCategories: [],
    questionEnum: EnumState.initial,
  );

  QuestionState copyWith({
    String? errorMessage,
    List<QuestionsModel>? question,
    List<QuestionCategoriesModel>? questionCategories,
    EnumState? questionEnum,
  }) {
    return QuestionState(
      errorMessage: errorMessage ?? this.errorMessage,
      question: question ?? this.question,
      questionCategories: questionCategories ?? this.questionCategories,
      questionEnum: questionEnum ?? this.questionEnum,
    );
  }

  @override
  List<Object?> get props => [errorMessage, question, questionCategories, questionEnum];
}
