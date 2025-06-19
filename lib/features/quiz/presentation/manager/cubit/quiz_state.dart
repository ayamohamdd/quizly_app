abstract class QuizState {}

final class QuizInitial extends QuizState {}
class QuizSettingsState extends QuizState{
  final Set<String> selectedLevels;
  final int? selectedNumber;

   QuizSettingsState({
    this.selectedLevels = const {},
    this.selectedNumber,
  });

  bool get isValid =>
      selectedLevels.isNotEmpty && selectedNumber != null;

  QuizSettingsState copyWith({
    Set<String>? selectedLevels,
    int? selectedNumber,
  }) {
    return QuizSettingsState(
      selectedLevels: selectedLevels ?? this.selectedLevels,
      selectedNumber: selectedNumber ?? this.selectedNumber,
    );
  }
}