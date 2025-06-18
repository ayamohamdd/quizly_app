import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/core/utils/use_cases/use_case.dart';
import 'package:quizly_app/features/units/domain/repos/units_repo.dart';

class UnitsUseCase
    extends UseCase<Future<Either<Failure, List<Map<String, dynamic>>>>, NoParam> {
  final UnitsRepo unitsRepo;

  UnitsUseCase({required this.unitsRepo});

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call([NoParam? n]) async {
    return await unitsRepo.fetchUnits();
  }
}
