import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quizly_app/core/app_router/app_routers.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/widgets/custom_button.dart';
import 'package:quizly_app/features/skill_performance/presentation/manager/cubit/skill_performance_cubit.dart';
import 'package:quizly_app/features/skill_performance/presentation/manager/cubit/skill_performance_state.dart';

class SkillPerformanceView extends StatelessWidget {
  const SkillPerformanceView({super.key, required this.skillId});
  final int? skillId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Skill Performance")),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.03,
          vertical: context.screenHeight * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(""),
            BlocConsumer<SkillPerformanceCubit, SkillPerformanceState>(
              builder: (context, state) {
                return CustomButton(
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.surface,
                  text: "Create Quiz",
                  isLoading: state is SkillPerformanceCreateQuizLoading,
                  onPressed: () {
                    SetupSeviceLocator.sl<SkillPerformanceCubit>().createQuiz(
                      skillId,
                    );
                  },
                );
              },
              listener: (BuildContext context, SkillPerformanceState state) {
                if (state is SkillPerformanceCreateQuizSuccess) {
                  GoRouter.of(
                    context,
                  ).pushReplacement(AppRouter.preQuizView, extra: state.quizId);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
