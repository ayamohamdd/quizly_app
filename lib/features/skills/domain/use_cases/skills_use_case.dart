import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/core/utils/use_cases/use_case.dart';
import 'package:quizly_app/features/skills/data/models/skill_model.dart';
import 'package:quizly_app/features/skills/domain/repos/skills_repo.dart';

class SkillsUseCase
    extends UseCase<Future<Either<Failure, List<SkillModel>>>, int?> {
  final SkillsRepo skillsRepo;

  SkillsUseCase({required this.skillsRepo});

  @override
  Future<Either<Failure, List<SkillModel>>> call([int? unitId]) async {
    return await skillsRepo.fetchSkills(unitId);
  }
}
