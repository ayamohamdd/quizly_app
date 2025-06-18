// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class UnitsDataSource {
  Future<List<Map<String, dynamic>>> fetchunits();
}

class UnitsDataSourceImpl extends UnitsDataSource {
  SqfliteProvider sqfliteProvider;
  UnitsDataSourceImpl({required this.sqfliteProvider});
  @override
  Future<List<Map<String, dynamic>>> fetchunits() async {
    Database db = await sqfliteProvider.openDatabaseFromAssets();
    return sqfliteProvider.getUnits(db);
  }
}
