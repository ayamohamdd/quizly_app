import 'package:quizly_app/features/quiz/domain/entities/quiz_question_entity.dart';

abstract class QuizState {}

final class QuizInitial extends QuizState {}

class QuizSettingsState extends QuizState {
  final List<String> selectedLevels;
  final int? selectedNumber;
  final bool? isLoading;
  final bool? isError;
  final bool? isSuccess;
  final List<QuizQuestionEntity>? questions;

  QuizSettingsState({
    this.isLoading,
    this.isError,
    this.isSuccess,
    this.questions,
    this.selectedLevels = const [],
    this.selectedNumber,
  });

  bool get isValid => selectedLevels.isNotEmpty && selectedNumber != null;

  QuizSettingsState copyWith({
    List<String>? selectedLevels,
    int? selectedNumber,
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    List<QuizQuestionEntity>? questions,
  }) {
    return QuizSettingsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      selectedLevels: selectedLevels ?? this.selectedLevels,
      selectedNumber: selectedNumber ?? this.selectedNumber,
      questions: questions ?? this.questions,
    );
  }
}
