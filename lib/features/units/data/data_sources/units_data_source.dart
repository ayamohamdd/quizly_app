import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:quizly_app/features/units/data/models/unit_model.dart';

abstract class UnitsDataSource {
  Future<List<UnitModel>> fetchunits();
}

class UnitsDataSourceImpl extends UnitsDataSource {
  SqfliteProvider sqfliteProvider;
  UnitsDataSourceImpl({required this.sqfliteProvider});
  @override
  Future<List<UnitModel>> fetchunits() async {
    // Database db = await sqfliteProvider.openDatabaseFromAssets();
    final List<Map<String, dynamic>> unitsData = await sqfliteProvider.getUnits(
      // SqfliteProvider.db!,
    );

    List<UnitModel> unitList =
        unitsData.map((map) => UnitModel.fromDatabase(map)).toList();

    return unitList;
  }
}
