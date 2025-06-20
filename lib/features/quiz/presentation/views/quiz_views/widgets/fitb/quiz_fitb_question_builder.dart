import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  });

  final PageController pageController;
  final QuizQuestionEntity questionEntity;
  final int questionIndex;
  final int questionsLength;

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
                Text(
                  "${questionEntity.questionText} = ?",
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.05),
                Expanded(child: QuizFitbAnswer(questionId: questionEntity.id)),
                BlocBuilder<QuizCubit, QuizSettingsState>(
                  builder: (context, state) {
                    final answer = state.fitbAnswers[questionEntity.id]?.trim();
                    final correct =
                        state.questions![questionIndex].correctAnswer;

                    return CustomButton(
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.onTertiary,
                      text: 'Submit',
                      onPressed: () {
                        if (answer != null && answer.toLowerCase() == correct) {
                          FocusManager.instance.primaryFocus?.unfocus();

                          pageController.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          showBottomSheet(
                            context: context,
                            builder:
                                (_) => ExplanationBottomSheet(
                                  explanation: questionEntity.explanation,
                                ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
