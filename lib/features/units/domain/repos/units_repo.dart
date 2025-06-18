import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';

abstract class UnitsRepo {
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchUnits();
}
