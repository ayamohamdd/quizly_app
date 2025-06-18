import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/skills/data/models/skill_model.dart';

abstract class SkillsRepo {
  Future<Either<Failure, List<SkillModel>>> fetchSkills(int? unitId);
}
