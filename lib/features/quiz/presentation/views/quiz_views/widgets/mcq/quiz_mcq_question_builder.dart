import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/core/widgets/custom_button.dart';
import 'package:quizly_app/features/quiz/domain/entities/quiz_question_entity.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/explanation_bottom_sheet.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/mcq/quiz_mcq_options.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/quiz_progression_bar.dart';

class QuizMcqAnswerBuilder extends StatelessWidget {
  const QuizMcqAnswerBuilder({
    super.key,
    required this.pageController,

    required this.questionIndex,
    required this.questionsLength,
    required this.questionEntity,
    required this.quizId,
  });

  final PageController pageController;
  final int quizId;
  final int questionIndex;
  final int questionsLength;
  final QuizQuestionEntity questionEntity;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuizProgressionBar(
                  length: questionsLength,
                  index: questionIndex,
                ),
                SizedBox(height: context.screenHeight * 0.05),
                Expanded(
                  child: Text(
                    "${questionEntity.questionText} = ?",
                    style: AppTextStyles.heading3.copyWith(
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.05),
                Expanded(
                  flex: 9,
                  child: QuizMcqOptions(
                    questionOptions: questionEntity.mcqOptions!,
                    questionId: questionEntity.id!,
                  ),
                ),
                _buildSubmitButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizSettingsState>(
      builder: (context, state) {
        final selected = state.selectedMcqOptions[questionEntity.id];
        final isDisabled = state.disabledQuestions[questionEntity.id] ?? false;
        final isCorrect = selected == questionEntity.correctAnswer;

        return CustomButton(
          backgroundColor: AppColors.primary,
          textColor: AppColors.onTertiary,
          text: 'Submit',
          onPressed:
              isDisabled
                  ? null
                  : () => _handleSubmission(context, selected, isCorrect),
        );
      },
    );
  }

  void _handleSubmission(
    BuildContext context,
    String? selected,
    bool isCorrect,
  ) {
    final cubit = SetupSeviceLocator.sl<QuizCubit>();
    final questionId = questionEntity.id!;
    final level = questionEntity.level;

    if (isCorrect) {
      cubit.insertQuizQuestion(quizId, questionId, level, selected, 1);
      _goToNextPage();
    } else {
      cubit.disableQuestion(questionId);
      _showExplanation(context, selected);
    }
  }

  void _showExplanation(BuildContext context, String? selected) {
    final cubit = SetupSeviceLocator.sl<QuizCubit>();
    final questionId = questionEntity.id!;
    final level = questionEntity.level;

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder:
          (_) => ExplanationBottomSheet(
            explanation: questionEntity.explanation,
            onNext: () {
              Navigator.of(context).pop();
              cubit.insertQuizQuestion(quizId, questionId, level, selected, 0);
              _goToNextPage();
            },
          ),
    );
  }

  void _goToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
