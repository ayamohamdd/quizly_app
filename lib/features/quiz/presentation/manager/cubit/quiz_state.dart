import 'package:quizly_app/features/quiz/domain/entities/quiz_question_entity.dart';

abstract class QuizState {}

final class QuizInitial extends QuizState {}

class QuizSettingsState extends QuizState {
  final List<String> selectedLevels;
  final int? selectedNumber;
  final bool? isLoading;
  final bool? isError;
  final String? errorMessage;

  final bool? isSuccess;
  final List<QuizQuestionEntity>? questions;
  final Map<int, String> selectedMcqOptions;
  final Map<int, String> fitbAnswers;
  final bool? insertLoading;

  final bool? insertSuccess;
  final bool? insertError;

  QuizSettingsState({
    this.isLoading,
    this.isError,
    this.errorMessage,
    this.isSuccess,
    this.questions,
    this.selectedLevels = const [],
    this.selectedNumber,
    this.selectedMcqOptions = const {},
    this.fitbAnswers = const {},
    this.insertLoading,
    this.insertSuccess,
    this.insertError,
  });

  bool get isValid => selectedLevels.isNotEmpty && selectedNumber != null;

  QuizSettingsState copyWith({
    List<String>? selectedLevels,
    int? selectedNumber,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    bool? isSuccess,
    List<QuizQuestionEntity>? questions,
    Map<int, String>? selectedMcqOptions,
    Map<int, String>? fitbAnswers,
    final bool? insertLoading,

    final bool? insertSuccess,
    final bool? insertError,
  }) {
    return QuizSettingsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedLevels: selectedLevels ?? this.selectedLevels,
      selectedNumber: selectedNumber ?? this.selectedNumber,
      questions: questions ?? this.questions,
      selectedMcqOptions: selectedMcqOptions ?? this.selectedMcqOptions,
      fitbAnswers: fitbAnswers ?? this.fitbAnswers,
      insertLoading: insertLoading ?? this.insertLoading,
      insertSuccess: insertSuccess ?? this.insertSuccess,
      insertError: insertError ?? this.insertError,
    );
  }
}
