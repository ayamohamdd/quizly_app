import 'package:quizly_app/features/units/data/models/unit_model.dart';

abstract class UnitsState {}

final class UnitInitial extends UnitsState {}

final class FetchUnitsLoading extends UnitsState {}

final class FetchUnitsSuccess extends UnitsState {
  final List<UnitModel> units;

  FetchUnitsSuccess({required this.units});
}

final class FetchUnitsError extends UnitsState {
  final String error;

  FetchUnitsError({required this.error});
}
