import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/units/data/data_sources/units_data_source.dart';
import 'package:quizly_app/features/units/domain/repos/units_repo.dart';

class UnitsRepoImpl extends UnitsRepo {
  final UnitsDataSource unitsDataSource;

  UnitsRepoImpl({required this.unitsDataSource});
  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchUnits() async {
    try {
      final units = await unitsDataSource.fetchunits();
      return Right(units);
    } catch (e) {
      return Left(DatabaseFailure.queryError(query: 'SELECT * FROM units'));
    }
  }
}
