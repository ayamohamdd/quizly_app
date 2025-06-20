import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quizly_app/core/app_router/app_routers.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/core/widgets/custom_button.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';
import 'package:quizly_app/features/quiz/presentation/views/pre_quiz_views/widgets/quiz_level.dart';
import 'package:quizly_app/features/quiz/presentation/views/pre_quiz_views/widgets/quiz_number_of_questions.dart';

class PreQuizView extends StatefulWidget {
  const PreQuizView({super.key});

  @override
  State<PreQuizView> createState() => _PreQuizViewState();
}

class _PreQuizViewState extends State<PreQuizView> {
  final List<int> numberOfQuestions = [5, 10, 25, 50];
  final Set<String> levels = {'easy', 'medium', 'hard'};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.05,
          vertical: context.screenHeight * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Questions Level", style: AppTextStyles.heading2),
            SizedBox(height: context.screenHeight * 0.02),
            QuizLevel(levels: levels),
            SizedBox(height: context.screenHeight * 0.02),
            Text("Number of Questions", style: AppTextStyles.heading2),
            SizedBox(height: context.screenHeight * 0.02),
            QuizNumberOfQuestions(numberOfQuestions: numberOfQuestions),
            Spacer(),
            BlocBuilder<QuizCubit, QuizSettingsState>(
              builder: (context, state) {
                final bool isSelected =
                    state.selectedLevels.isNotEmpty &&
                    state.selectedNumber != null;
                return CustomButton(
                  borderColor:
                      isSelected
                          ? AppColors.primary
                          : AppColors.onSurfaceDisabled,
                  backgroundColor:
                      isSelected
                          ? AppColors.primary
                          : AppColors.onSurfaceDisabled,
                  text: "Start Quiz",
                  textColor: AppColors.surface,
                  onPressed: () {
                    SetupSeviceLocator.sl<QuizCubit>().fetchQuizQuerstions(
                      1,
                      state.selectedNumber!,
                      state.selectedLevels,
                    );

                    GoRouter.of(context).pushReplacement(AppRouter.quizView);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
