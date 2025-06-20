import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:quizly_app/features/skills/data/models/skill_model.dart';

abstract class SkillsDataSource {
  Future<List<SkillModel>> fetchSkills(int? unitId);
}

class SkillsDataSourceImpl extends SkillsDataSource {
  SqfliteProvider sqfliteProvider;
  SkillsDataSourceImpl({required this.sqfliteProvider});
  @override
  Future<List<SkillModel>> fetchSkills(int? unitId) async {
    final List<Map<String, dynamic>> skillsData = await sqfliteProvider
        .getSkills( unitId!);

    List<SkillModel> unitList =
        skillsData.map((map) => SkillModel.fromDatabase(map)).toList();

    return unitList;
  }
}
