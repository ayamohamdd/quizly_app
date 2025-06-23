import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/core/widgets/custom_button.dart';
import 'package:quizly_app/features/quiz_performance/presentation/manager/cubit/quiz_performance_cubit.dart';
import 'package:quizly_app/features/quiz_performance/presentation/manager/cubit/quiz_performance_state.dart';
import 'package:quizly_app/features/quiz_performance/presentation/views/widgets/quiz_level_scores_grid_item.dart';
import 'package:quizly_app/features/quiz_performance/presentation/views/widgets/quiz_score_card.dart';
import 'package:quizly_app/features/quiz_performance/presentation/views/widgets/quiz_wrong_question_item.dart';

class QuizPerformanceView extends StatelessWidget {
  const QuizPerformanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Performance")),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.05,
          vertical: context.screenHeight * 0.02,
        ),
        child: BlocBuilder<QuizPerformanceCubit, GetQuizPerformanceState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Performance", style: AppTextStyles.heading2),
                  SizedBox(height: context.screenHeight * 0.025),

                  QuizScoreCard(score: state.score ?? 0),
                  SizedBox(height: context.screenHeight * 0.03),

                  if (state.quizPerformanceList != null)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.quizPerformanceList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: context.screenHeight * 0.02,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2,
                      ),
                      itemBuilder: (context, index) {
                        final performance = state.quizPerformanceList![index];
                        return QuizLevelScoresGridItem(
                          level: performance.questionLevel!,
                          score: performance.percentage,
                        );
                      },
                    ),

                  if (state.quizWrongQuestionsList != null &&
                      state.quizWrongQuestionsList!.isNotEmpty) ...[
                    SizedBox(height: context.screenHeight * 0.05),
                    Text("Mistakes", style: AppTextStyles.heading2),
                    Column(
                      children:
                          state.quizWrongQuestionsList!
                              .map(
                                (e) => QuizWrongQuestionItem(
                                  text: e.questionText!,
                                ),
                              )
                              .toList(),
                    ),
                  ],

                  SizedBox(height: context.screenHeight * 0.1),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: context.screenWidth * 0.03,
          right: context.screenWidth * 0.03,

          bottom: context.screenHeight * 0.05,
        ),
        child: CustomButton(
          backgroundColor: AppColors.primary,
          borderColor: AppColors.primary,
          textColor: AppColors.surface,
          text: "Create Quiz",
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
    );
  }
}
