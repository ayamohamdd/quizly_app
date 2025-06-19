import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/features/quiz/domain/entities/fetch_questions_param_entity.dart';
import 'package:quizly_app/features/quiz/domain/use_cases/fetch_questions_use_case.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';

class QuizCubit extends Cubit<QuizSettingsState> {
  QuizCubit()
    : _fetchQuestionsUseCase = SetupSeviceLocator.sl.get(),
      super(QuizSettingsState());
  final FetchQuestionsUseCase _fetchQuestionsUseCase;

  void toggleLevel(String level) {
    final newSet = List<String>.from(state.selectedLevels);
    newSet.contains(level) ? newSet.remove(level) : newSet.add(level);
    emit(state.copyWith(selectedLevels: newSet));
  }

  void selectNumber(int number) {
    emit(state.copyWith(selectedNumber: number));
  }

  Future<void> fetchQuizQuerstions(
    int skillId,
    int numberOfQuestions,
    List<String> levels,
  ) async {
    FetchQuestionsParamEntity fetchQuestionsParamEntity =
        FetchQuestionsParamEntity(
          skillId: skillId,
          numberOfQuestions: numberOfQuestions,
          levels: levels,
        );
    log("$levels");
    emit(state.copyWith(isLoading: true));
    final result = await _fetchQuestionsUseCase.call(fetchQuestionsParamEntity);
    result.fold(
      (l) {
        emit(state.copyWith(isError: true));
      },
      (r) {
        emit(state.copyWith(isSuccess: true, isLoading: false, questions: r));
      },
    );
  }
}
