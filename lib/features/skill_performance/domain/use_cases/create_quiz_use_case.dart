import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/core/utils/use_cases/use_case.dart';
import 'package:quizly_app/features/skill_performance/domain/repos/skill_performance_repo.dart';

class CreateQuizUseCase extends UseCase<Future<Either<Failure, void>>, int?> {
  final SkillPerformanceRepo skillPerformanceRepo;

  CreateQuizUseCase({required this.skillPerformanceRepo});

  @override
  Future<Either<Failure, void>> call([int? skillId]) async {
    return await skillPerformanceRepo.createQuiz(skillId);
  }
}
