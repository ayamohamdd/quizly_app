// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quizly_app/core/sqflite/sqflite_provider.dart';

abstract class SkillPerformanceDataSource {
  Future<int> createQuiz(int? skillId);
}

class SkillPerformanceDataSourceImpl extends SkillPerformanceDataSource {
  SqfliteProvider sqfliteProvider;
  SkillPerformanceDataSourceImpl({required this.sqfliteProvider});
  @override
  Future<int> createQuiz(int? skillId) async {
    return await sqfliteProvider.insertQuiz(skillId!);
  }
}
