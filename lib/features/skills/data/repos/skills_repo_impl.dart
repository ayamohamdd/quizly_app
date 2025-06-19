import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/skills/data/data_sources/skills_data_source.dart';
import 'package:quizly_app/features/skills/data/models/skill_model.dart';
import 'package:quizly_app/features/skills/domain/repos/skills_repo.dart';

class SkillsRepoImpl extends SkillsRepo {
  final SkillsDataSource skillsDataSource;

  SkillsRepoImpl({required this.skillsDataSource});
  @override
  Future<Either<Failure, List<SkillModel>>> fetchSkills(int? unitId) async {
    try {
      final skills = await skillsDataSource.fetchSkills(unitId);
      return Right(skills);
    } catch (e) {
      return Left(DatabaseFailure.queryError(query: 'SELECT * FROM skills'));
    }
  }
}
