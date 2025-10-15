import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/core/utils/enum_state.dart';
import 'package:screens/data/repositories/question_repositories.dart';
import 'package:screens/features/question/managers/question_event.dart';
import 'package:screens/features/question/managers/question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionRepositories _questionRepo;

  QuestionBloc({
    required QuestionRepositories questionRepo,
  }) : _questionRepo = questionRepo,
       super(QuestionState.initial()) {
    on<QuestionListEvent>(_fetchQuestionList);
    on<QuestionCategoriesListEvent>(_fetchQuestionCategoriesList);
    add(QuestionListEvent());
    add(QuestionCategoriesListEvent());
  }

  Future<void> _fetchQuestionList(QuestionListEvent event, Emitter<QuestionState> emit) async {
    emit(state.copyWith(questionEnum: EnumState.loading));
    final result = await _questionRepo.getQuestion();

    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), questionEnum: EnumState.error)),
      (success) {
        emit(
          state.copyWith(question: success, questionEnum: EnumState.success),
        );
      },
    );
  }

  Future<void> _fetchQuestionCategoriesList(QuestionCategoriesListEvent event, Emitter<QuestionState> emit) async {
    emit(state.copyWith(questionEnum: EnumState.loading));
    final result = await _questionRepo.getQuestionCategories();

    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), questionEnum: EnumState.error)),
      (success) {
        emit(
          state.copyWith(questionCategories: success, questionEnum: EnumState.success),
        );
      },
    );
  }
}
