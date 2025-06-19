import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:quizly_app/features/skills/data/models/skill_model.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class SkillsDataSource {
  Future<List<SkillModel>> fetchSkills(int? unitId);
}

class SkillsDataSourceImpl extends SkillsDataSource {
  SqfliteProvider sqfliteProvider;
  SkillsDataSourceImpl({required this.sqfliteProvider});
  @override
  Future<List<SkillModel>> fetchSkills(int? unitId) async {
    // Database db = await sqfliteProvider.openDatabaseFromAssets();
    final List<Map<String, dynamic>> skillsData = await sqfliteProvider
        .getSkills(SqfliteProvider.db!, unitId!);

    List<SkillModel> unitList =
        skillsData.map((map) => SkillModel.fromDatabase(map)).toList();

    return unitList;
  }
}
