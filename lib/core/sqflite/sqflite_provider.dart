
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:io';

class SqfliteProvider {
  static Database? db;
  static Future<Database> get database async {
    if (db != null) return db!;
    db = await openDatabaseFromAssets();
    return db!;
  }

  static Future<Database> openDatabaseFromAssets() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'questions.db');

    final exists = await databaseExists(path);

    if (!exists) {
      ByteData data = await rootBundle.load('assets/database/math_quiz.db');
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      final file = File(path);
      await file.writeAsBytes(bytes, flush: true);
    }

    return openDatabase(path, onCreate: _onCreate, version: 1);
  }

  static _onCreate(Database db, int version) async {
    await createQuizzesTable();
    await createQuizQuestionsTable();
  }

  Future<List<Map<String, dynamic>>> getUnits() async {
    return await db!.query('units');
  }

  Future<List<Map<String, dynamic>>> getSkills(int unitId) async {
    return await db!.query('skills', where: 'unit_id= ?', whereArgs: [unitId]);
  }

  Future<List<Map<String, dynamic>>> getQuestions(
    int skillId,
    List<String> levels,
    int numberOfQuestions,
  ) async {
    final levelPlaceholders = List.filled(levels.length, '?').join(', ');
    final whereClause = 'skill_id = ? AND level IN ($levelPlaceholders)';
    final whereArgs = [skillId, ...levels];
    final response = await db!.query(
      'questions',
      where: whereClause,
      whereArgs: whereArgs,
      limit: numberOfQuestions,
      orderBy: 'RANDOM()',
    );


    return response;
  }

  Future<List<Map<String, dynamic>>> getMcqOptions(
    // Database db,
    int questionId,
  ) async {
    final response = await db!.query(
      'mcq_options',
      where: 'question_id= ?',
      whereArgs: [questionId],
    );
    return response;
  }

  static Future<void> createQuizzesTable() async {
    await db!.execute('''
    CREATE TABLE quizzes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    skill_id INTEGER NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
    );
    ''');
  }

  static Future<void> createQuizQuestionsTable() async {
    await db!.execute('''
   CREATE TABLE quiz_questions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    quiz_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    user_answer TEXT,
    is_correct INTEGER CHECK (is_correct IN (0, 1)),
    answered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

    ''');
  }

  Future<List<Map<String, dynamic>>> getQuiz(int skillId) async {
    return await db!.query(
      'quizzes',
      where: 'skill_id= ?',
      whereArgs: [skillId],
    );
  }

  Future<List<Map<String, dynamic>>> getSkillsPerformance(
    // Database db,
    int skillId,
  ) async {
    return await db!.rawQuery(
      '''
    SELECT level, 
    COUNT(*) AS total,
    SUM(is_correct) AS correct,
    ROUND(SUM(is_correct) * 100.0 / COUNT(*), 2) AS percentage
    FROM questions q
    JOIN quiz_questions qq ON q.id = qq.question_id
    WHERE q.skill_id = ? 
    GROUP BY level;
    ''',
      [skillId],
    );
  }
}
