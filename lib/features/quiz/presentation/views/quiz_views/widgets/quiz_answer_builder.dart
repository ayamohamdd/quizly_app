import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/core/widgets/custom_button.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/explanation_bottom_sheet.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/quiz_progression_bar.dart';

class QuizAnswerBuilder extends StatelessWidget {
  const QuizAnswerBuilder({
    super.key,
    required this.pageController,
    required this.answer,
    required this.questionText,
    required this.questionIndex,
    required this.questionsLength,
    required this.questionId,
    required this.explanation, 
  });
  final PageController pageController;
  final Widget answer;
  final int questionId;
  final String questionText;
  final String explanation;
  final int questionIndex;
  final int questionsLength;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuizProgressionBar(
                  length: questionsLength,
                  index: questionIndex,
                ),
                SizedBox(height: context.screenHeight * 0.05),
                Text(
                  "$questionText = ?",
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.05),
                Expanded(child: answer),
                BlocBuilder<QuizCubit, QuizSettingsState>(
                  builder: (context, state) {
                    return CustomButton(
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.onTertiary,
                      borderColor: AppColors.primary,
                      text: 'Submit',
                      onPressed: () {
                        if (state.selectedMcqOptions[questionId] ==
                            state.questions![questionIndex].correctAnswer) {
                          pageController.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          showBottomSheet(
                            context: context,
                            builder: (context) {
                              return ExplanationBottomSheet(
                                explanation: explanation, onNext: () {  },
                              );
                            },
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
