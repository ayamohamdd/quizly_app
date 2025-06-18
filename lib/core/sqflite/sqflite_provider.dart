import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:io';

class SqfliteProvider {
  Future<Database> openDatabaseFromAssets() async {
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

    return openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getUnits(Database db) async {
    return await db.query('units');
  }

   Future<List<Map<String, dynamic>>> getSkills(Database db,int unitId) async {
    return await db.query('skills',where: 'unit_id= ?',whereArgs: [unitId] );
  }


}
