import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/features/quiz/domain/entities/fetch_questions_param_entity.dart';
import 'package:quizly_app/features/quiz/domain/entities/insert_quiz_question_param_entity.dart';
import 'package:quizly_app/features/quiz/domain/use_cases/fetch_questions_use_case.dart';
import 'package:quizly_app/features/quiz/domain/use_cases/insert_quiz_question_use_case.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';

class QuizCubit extends Cubit<QuizSettingsState> {
  QuizCubit()
    : _fetchQuestionsUseCase = SetupSeviceLocator.sl.get(),
      _insertQuizQuestionUseCase = SetupSeviceLocator.sl.get(),

      super(QuizSettingsState());
  final FetchQuestionsUseCase _fetchQuestionsUseCase;
  final InsertQuizQuestionUseCase _insertQuizQuestionUseCase;

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
    emit(state.copyWith(isLoading: true));
    final result = await _fetchQuestionsUseCase.call(fetchQuestionsParamEntity);
    result.fold(
      (l) {
        emit(state.copyWith(isError: true, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(isSuccess: true, isLoading: false, questions: r));
      },
    );
  }

  void selectMcqOption(int questionIndex, String selectedOptionIndex) {
    final updatedSelections = Map<int, String>.from(state.selectedMcqOptions);
    updatedSelections[questionIndex] = selectedOptionIndex;
    log("$updatedSelections");

    emit(state.copyWith(selectedMcqOptions: updatedSelections));
  }

  void setFITBAnswer(int questionId, String answer) {
    final updatedAnswers = Map<int, String>.from(state.fitbAnswers);
    updatedAnswers[questionId] = answer;
    emit(state.copyWith(fitbAnswers: updatedAnswers));
  }

  Future<void> insertQuizQuestion(
    int? quizId,
    int? questionId,
    String? questionLevel,

    String? userAnswer,

    int? isCorrect,
  ) async {
    emit(state.copyWith(insertLoading: true));
    InsertQuizQuestionParamEntity insertQuizQuestionParamEntity =
        InsertQuizQuestionParamEntity(
          quizId: quizId,
          questionId: questionId,
          questionLevel: questionLevel,
          userAnswer: userAnswer,
          isCorrect: isCorrect,
        );
    log("ehhhhhhh ${insertQuizQuestionParamEntity.questionLevel}");
    final result = await _insertQuizQuestionUseCase.call(
      insertQuizQuestionParamEntity,
    );
    result.fold(
      (l) {
        emit(
          state.copyWith(
            insertLoading: false,
            insertError: true,
            errorMessage: l.message,
          ),
        );
      },
      (r) {
        emit(state.copyWith(insertLoading: false, insertSuccess: true));
      },
    );
  }

  final Map<int, bool> disabledQuestions = {};

  void disableQuestion(int questionId) {
    // disabledQuestions[questionId] = true;
    emit(state.copyWith(disabledQuestions: {questionId: true}));
  }
}
