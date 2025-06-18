import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/features/units/domain/use_cases/units_use_case.dart';
import 'package:quizly_app/features/units/presentation/manager/cubit/unit_state.dart';

class UnitsCubit extends Cubit<UnitsState> {
  UnitsCubit()
    : _unitsUseCase = SetupSeviceLocator.sl.get(),
      super(UnitInitial());
  final UnitsUseCase _unitsUseCase;
  Future<void> fetchUnits() async {
    emit(FetchUnitsLoading());
    final result = await _unitsUseCase.call();
    result.fold((e) => emit(FetchUnitsError(error: e.message)), (units) {
      print(units.length);
      emit(FetchUnitsSuccess(units: units));
    });
  }
}
