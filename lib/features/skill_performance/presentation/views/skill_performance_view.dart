import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quizly_app/core/app_router/app_routers.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/core/widgets/custom_button.dart';
import 'package:quizly_app/features/quiz_performance/presentation/views/widgets/quiz_level_scores_grid_item.dart';
import 'package:quizly_app/features/quiz_performance/presentation/views/widgets/quiz_wrong_question_item.dart';
import 'package:quizly_app/features/skill_performance/presentation/manager/cubit/skill_performance_cubit.dart';
import 'package:quizly_app/features/skill_performance/presentation/manager/cubit/skill_performance_state.dart';

class SkillPerformanceView extends StatelessWidget {
  const SkillPerformanceView({
    super.key,
    required this.skillId,
    required this.skillName,
  });
  final int? skillId;
  final String skillName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Skill Performance")),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.03,
          vertical: context.screenHeight * 0.05,
        ),
        child: BlocConsumer<SkillPerformanceCubit, SkillPerformanceStates>(
          listener: (BuildContext context, SkillPerformanceStates state) {
            if (state.createSuccess == true) {
              GoRouter.of(context).pushReplacement(
                AppRouter.preQuizView,
                extra: {"quiz_id": state.quizId, "skill_id": skillId},
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Skill: $skillName", style: AppTextStyles.heading2),
                  SizedBox(height: context.screenHeight * 0.025),

                  if (state.skillPerformanceList != null)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.skillPerformanceList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: context.screenHeight * 0.02,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2,
                      ),
                      itemBuilder: (context, index) {
                        final performance = state.skillPerformanceList![index];
                        return QuizLevelScoresGridItem(
                          level: performance.questionLevel!,
                          score: performance.percentage,
                        );
                      },
                    ),

                  if (state.skillWrongQuestionsList != null &&
                      state.skillWrongQuestionsList!.isNotEmpty) ...[
                    SizedBox(height: context.screenHeight * 0.05),
                    Text("Mistakes", style: AppTextStyles.heading2),
                    Column(
                      children:
                          state.skillWrongQuestionsList!
                              .map(
                                (e) => QuizWrongQuestionItem(
                                  text: e.questionText!,
                                ),
                              )
                              .toList(),
                    ),
                  ],

                  SizedBox(height: context.screenHeight * 0.1),
                  Text(""),
                  // CustomButton(
                  //   backgroundColor: AppColors.primary,
                  //   borderColor: AppColors.primary,
                  //   textColor: AppColors.surface,
                  //   text: "Create Quiz",
                  //   isLoading: state.createLoading == true ? true : false,
                  //   onPressed: () {
                  //     context.read<SkillPerformanceCubit>().createQuiz(skillId);
                  //   },
                  // ),
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
        child: BlocBuilder<SkillPerformanceCubit, SkillPerformanceStates>(
          builder: (context, state) {
            return CustomButton(
              backgroundColor: AppColors.primary,
              borderColor: AppColors.primary,
              textColor: AppColors.surface,
              text: "Create Quiz",
              isLoading: state.createLoading == true,
              onPressed: () {
                context.read<SkillPerformanceCubit>().createQuiz(skillId);
              },
            );
          },
        ),
      ),
    );
  }
}
