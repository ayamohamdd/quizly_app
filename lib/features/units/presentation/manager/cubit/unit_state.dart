abstract class UnitsState {}

final class UnitInitial extends UnitsState {}

final class FetchUnitsLoading extends UnitsState {}

final class FetchUnitsSuccess extends UnitsState {
  final List<Map<String, dynamic>> units;

  FetchUnitsSuccess({required this.units});
}

final class FetchUnitsError extends UnitsState {
  final String error;

  FetchUnitsError({required this.error});
}
