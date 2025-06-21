import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/features/skill_performance/domain/use_cases/create_quiz_use_case.dart';
import 'package:quizly_app/features/skill_performance/presentation/manager/cubit/skill_performance_state.dart';

class SkillPerformanceCubit extends Cubit<SkillPerformanceState> {
  SkillPerformanceCubit()
    : _createQuizUseCase = SetupSeviceLocator.sl.get(),
      super(SkillPerformanceInitial());
  final CreateQuizUseCase _createQuizUseCase;

  Future<void> createQuiz(int? skillId) async {
    emit(SkillPerformanceCreateQuizLoading());
    final res = await _createQuizUseCase.call(skillId);
    res.fold(
      (l) {
        emit(SkillPerformanceCreateQuizFailure(error: l.message));
      },
      (r) {
        emit(SkillPerformanceCreateQuizSuccess(quizId: r));
      },
    );
  }
}
