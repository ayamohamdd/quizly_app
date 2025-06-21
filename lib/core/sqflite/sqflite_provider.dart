import 'dart:developer';

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

    // return openDatabase(path, onCreate: _onCreate, version: 1);
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  static _onCreate(Database db, int version) async {
    await createQuizzesTable(db);
    await createQuizQuestionsTable(db);
  }

  Future<List<Map<String, dynamic>>> getUnits() async {
    return await db!.query('units');
  }

  // Future<>
  Future<List<Map<String, dynamic>>> getSkills(int unitId) async {
    return await db!.query('skills', where: 'unit_id= ?', whereArgs: [unitId]);
  }

  Future<List<Map<String, dynamic>>> getQuestions(
    int skillId,
    List<String> levels,
    int numberOfQuestions,
  ) async {
    final levelPlaceholders = List.filled(levels.length, '?').join(', ');
    final whereArgs = [skillId, ...levels, numberOfQuestions];
    final response = await db!.rawQuery('''
    SELECT * FROM questions
    WHERE skill_id = ? AND level IN ($levelPlaceholders)
    ORDER BY RANDOM()
    LIMIT ?
  ''', whereArgs);
    log("response $response");
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

  static Future<void> createQuizzesTable(Database db) async {
    await db.execute('''
    CREATE TABLE quizzes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    skill_id INTEGER NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
    );
    ''');
  }

  static Future<void> createQuizQuestionsTable(Database db) async {
    await db.execute('''
   CREATE TABLE quiz_questions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    quiz_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    question_level TEXT CHECK (question_level IN ('easy', 'medium', 'hard')) NOT NULL,
    user_answer TEXT,
    is_correct INTEGER CHECK (is_correct IN (0, 1)),
    answered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

    ''');
  }

  Future<List<Map<String, dynamic>>> getAllQuestions() async {
    return await db!.query("quiz_questions");
  }

  Future<int> insertQuizQuestion(
    int quizId,
    int questionId,
    String questionLevel,
    String userAnswer,
    int isCorrect,
  ) async {
    log("quizId $quizId");
    final int id = await SqfliteProvider.db!.insert('quiz_questions', {
      'quiz_id': quizId,
      'question_id': questionId,
      'question_level': questionLevel,
      'user_answer': userAnswer,
      'is_correct': isCorrect == 1 ? 1 : 0,
    });

    log("$id  ");
    return id;
  }

  Future<int> insertQuiz(int skillId) async {
    return await db!.insert("quizzes", {"skill_id": skillId});
  }

  Future<List<Map<String, Object?>>> getQuizzes() async {
    return await db!.query('quizzes');
  }

  Future<List<Map<String, dynamic>>> getQuiz(int skillId) async {
    return await db!.query(
      'quizzes',
      where: 'skill_id= ?',
      whereArgs: [skillId],
    );
  }

  Future<List<Map<String, dynamic>>> getSkillsPerformance(int skillId) async {
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

  Future<List<Map<String, dynamic>>> getQuizScorePerLevel(int quizId) async {
    final result = await db!.rawQuery(
      '''
      SELECT qq.question_level, 
      COUNT(*) AS total,
      SUM(qq.is_correct) AS correct,
      ROUND(SUM(qq.is_correct) * 100.0 / COUNT(*), 2) AS percentage
      FROM quiz_questions qq
      WHERE qq.quiz_id = ?
      GROUP BY qq.question_level;
      ''',
      [quizId],
    );
    log("result $result, $quizId");
    return result;
  }
}
