import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quizly_app/core/app_router/app_routers.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/core/widgets/custom_button.dart';
import 'package:quizly_app/features/quiz/domain/entities/quiz_question_entity.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/explanation_bottom_sheet.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/fitb/quiz_fitb_answer.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/quiz_progression_bar.dart';

class QuizFitbAnswerBuilder extends StatelessWidget {
  const QuizFitbAnswerBuilder({
    super.key,
    required this.pageController,
    required this.questionIndex,
    required this.questionsLength,
    required this.questionEntity,
    required this.quizId,
  });

  final PageController pageController;
  final QuizQuestionEntity questionEntity;
  final int questionIndex;
  final int questionsLength;
  final int quizId;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuizProgressionBar(
                  length: questionsLength,
                  index: questionIndex,
                ),
                SizedBox(height: context.screenHeight * 0.05),
                Text(
                  "${questionEntity.questionText} = ?",
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.05),
                Expanded(child: QuizFitbAnswer(questionId: questionEntity.id)),
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
        final answer = state.fitbAnswers[questionEntity.id]?.trim();
        final correct = state.questions![questionIndex].correctAnswer;
        final isDisabled = state.disabledQuestions[questionEntity.id] ?? false;

        return CustomButton(
          backgroundColor: AppColors.primary,
          borderColor:
              answer != null ? AppColors.primary : AppColors.onSurfaceDisabled,

          textColor: AppColors.onTertiary,
          text: 'Submit',
          onPressed:
              answer != null
                  ? isDisabled
                      ? null
                      : () => _handleSubmit(context, answer, correct!)
                  : null,
        );
      },
    );
  }

  void _handleSubmit(BuildContext context, String? answer, String correct) {
    final cubit = context.read<QuizCubit>();
    final questionId = questionEntity.id!;
    final level = questionEntity.level;

    FocusScope.of(context).unfocus();

    if (answer != null && answer.toLowerCase() == correct) {
      cubit.insertQuizQuestion(quizId, questionId, level, answer, 1);
      _goToNextPage(context);
    } else {
      cubit.disableQuestion(questionId);
      _showExplanation(context, answer);
    }
  }

  void _showExplanation(BuildContext context, String? answer) {
    final cubit = context.read<QuizCubit>();
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
              cubit.insertQuizQuestion(quizId, questionId, level, answer, 0);
              _goToNextPage(context);
            },
          ),
    );
  }

  void _goToNextPage(BuildContext context) {
    if (questionIndex == questionsLength - 1) {
      GoRouter.of(
        context,
      ).pushReplacement(AppRouter.quizPerformanceView, extra: quizId);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
