import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/units/data/models/unit_model.dart';

abstract class UnitsRepo {
  Future<Either<Failure, List<UnitModel>>> fetchUnits();
}
