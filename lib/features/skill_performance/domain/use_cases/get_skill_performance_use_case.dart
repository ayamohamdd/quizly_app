import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/core/utils/use_cases/use_case.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/domain/repos/quiz_performance_repo.dart';
import 'package:quizly_app/features/skill_performance/domain/repos/skill_performance_repo.dart';

class GetSkillPerformanceUseCase
    extends UseCase<Future<Either<Failure, List<QuizPerformanceModel>>>, int?> {
  final SkillPerformanceRepo skillPerformanceRepo;

  GetSkillPerformanceUseCase({required this.skillPerformanceRepo});

  @override
  Future<Either<Failure, List<QuizPerformanceModel>>> call([
    int? skillId,
  ]) async {
    return await skillPerformanceRepo.getSkillPerformance(skillId);
  }
}
