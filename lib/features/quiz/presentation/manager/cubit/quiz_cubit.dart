import 'package:bloc/bloc.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';

class QuizSettingsCubit extends Cubit<QuizSettingsState> {
  QuizSettingsCubit() : super(QuizSettingsState());

  void toggleLevel(String level) {
    final newSet = Set<String>.from(state.selectedLevels);
    newSet.contains(level) ? newSet.remove(level) : newSet.add(level);
    emit(state.copyWith(selectedLevels: newSet));
  }

  void selectNumber(int number) {
    emit(state.copyWith(selectedNumber: number));
  }
}
