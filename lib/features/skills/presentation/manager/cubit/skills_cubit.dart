import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/features/skills/domain/use_cases/skills_use_case.dart';
import 'package:quizly_app/features/skills/presentation/manager/cubit/skills_state.dart';

class SkillsCubit extends Cubit<SkillsState> {
  SkillsCubit()
    : _skillsUseCase = SetupSeviceLocator.sl.get(),
      super(SkillsInitial());
  final SkillsUseCase _skillsUseCase;
  Future<void> fetchSkills(int? unitId) async {
    emit(FetchSkillsLoading());
    final result = await _skillsUseCase.call(unitId);
    result.fold((e) => emit(FetchSkillsError(error: e.message)), (skills) {
      emit(FetchSkillsSuccess(skills: skills));
    });
  }
}
