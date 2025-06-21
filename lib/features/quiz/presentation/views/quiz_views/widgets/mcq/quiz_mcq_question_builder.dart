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
  // final List<McqOptionsEntity> options;

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
                BlocBuilder<QuizCubit, QuizSettingsState>(
                  builder: (context, state) {
                    return CustomButton(
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.onTertiary,
                      text: 'Submit',
                      onPressed: () {
                        final selected =
                            state.selectedMcqOptions[questionEntity.id];
                        final correct =
                            state.questions![questionIndex].correctAnswer;

                        if (selected == correct) {
                          SetupSeviceLocator.sl<QuizCubit>().insertQuizQuestion(
                            quizId,
                            questionEntity.id,
                            selected,
                            1,
                          );
                          pageController.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          SetupSeviceLocator.sl<QuizCubit>().insertQuizQuestion(
                            quizId,
                            questionEntity.id,
                            selected,
                            0,
                          );
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
