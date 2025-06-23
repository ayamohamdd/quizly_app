import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/features/skill_performance/domain/use_cases/create_quiz_use_case.dart';
import 'package:quizly_app/features/skill_performance/domain/use_cases/fetch_skill_wrong_questions_use_case.dart';
import 'package:quizly_app/features/skill_performance/domain/use_cases/get_skill_performance_use_case.dart';
import 'package:quizly_app/features/skill_performance/presentation/manager/cubit/skill_performance_state.dart';

class SkillPerformanceCubit extends Cubit<SkillPerformanceStates> {
  SkillPerformanceCubit()
    : _createQuizUseCase = SetupSeviceLocator.sl.get(),
      _fetchSkillWrongQuestionsUseCase = SetupSeviceLocator.sl.get(),
      _getSkillPerformanceUseCase = SetupSeviceLocator.sl.get(),
      super(SkillPerformanceStates());
  final CreateQuizUseCase _createQuizUseCase;
  final FetchSkillWrongQuestionsUseCase _fetchSkillWrongQuestionsUseCase;
  final GetSkillPerformanceUseCase _getSkillPerformanceUseCase;

  Future<void> createQuiz(int? skillId) async {
    emit(state.copyWith(createLoading: true));
    final res = await _createQuizUseCase.call(skillId);
    res.fold(
      (l) {
        emit(
          state.copyWith(
            createLoading: false,
            createError: true,
            createErrorMessage: l.message,
          ),
        );
      },
      (r) {
        log("eh $r");
        emit(
          state.copyWith(createLoading: false, createSuccess: true, quizId: r),
        );
      },
    );
  }

  Future<void> getSkillWrongQuestions(int skillId) async {
    emit(state.copyWith(isLoading: true));
    final result = await _fetchSkillWrongQuestionsUseCase.call(skillId);
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
        log("wrong $r");
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            skillWrongQuestionsList: r,
          ),
        );
      },
    );
  }

  Future<void> getSkillPerformance(int skillId) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getSkillPerformanceUseCase.call(skillId);
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
        log("per $r");
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            skillPerformanceList: r,
          ),
        );
      },
    );
  }
}
