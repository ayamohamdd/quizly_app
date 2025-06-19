import 'package:quizly_app/features/skills/data/models/skill_model.dart';

abstract class SkillsState {}

final class SkillsInitial extends SkillsState {}

final class FetchSkillsLoading extends SkillsState {}

final class FetchSkillsSuccess extends SkillsState {
  final List<SkillModel> skills;

  FetchSkillsSuccess({required this.skills});
}

final class FetchSkillsError extends SkillsState {
  final String error;

  FetchSkillsError({required this.error});
}
