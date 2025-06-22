import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/domain/use_cases/fetch_quiz_wrong_questions_use_case.dart';
import 'package:quizly_app/features/quiz_performance/domain/use_cases/get_quiz_performance_use_case.dart';
import 'package:quizly_app/features/quiz_performance/domain/use_cases/get_quiz_score_use_case.dart';
import 'package:quizly_app/features/quiz_performance/presentation/manager/cubit/quiz_performance_state.dart';

class QuizPerformanceCubit extends Cubit<GetQuizPerformanceState> {
  QuizPerformanceCubit()
    : _getQuizPerformanceUseCase = SetupSeviceLocator.sl.get(),
      _getQuizScoreUseCase = SetupSeviceLocator.sl.get(),
      _fetchQuizWrongQuestionsUseCase = SetupSeviceLocator.sl.get(),

      super(GetQuizPerformanceState());

  final GetQuizPerformanceUseCase _getQuizPerformanceUseCase;
  final GetQuizScoreUseCase _getQuizScoreUseCase;
  final FetchQuizWrongQuestionsUseCase _fetchQuizWrongQuestionsUseCase;
  Future<void> getQuizPerformance(int quizId) async {
    emit(state.copyWith());
    final result = await _getQuizPerformanceUseCase.call(quizId);
    result.fold(
      (l) {
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: l.message,
          ),
        );
      },
      (r) {
        final double score = _getQuizScoreUseCase.call(r);
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            quizPerformanceList: r,
            score: score,
          ),
        );
      },
    );
  }

  void getQuizScore(List<QuizPerformanceModel> quizPerformanceList) {
    final double quizScore = _getQuizScoreUseCase.call(quizPerformanceList);
    emit(state.copyWith(score: quizScore));
  }

  Future<void> getQuizWrongQuestions(int quizId) async {
    emit(state.copyWith());
    final result = await _fetchQuizWrongQuestionsUseCase.call(quizId);
    log("cubit $result");
    result.fold(
      (l) {
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: l.message,
          ),
        );
      },
      (r) {
        log("hena $r");
        emit(state.copyWith(quizWrongQuestionsList: r));
      },
    );
  }
}
