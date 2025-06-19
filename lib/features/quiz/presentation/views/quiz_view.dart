import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/core/widgets/custom_button.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';
import 'package:quizly_app/features/quiz/presentation/views/widgets/quiz_level.dart';
import 'package:quizly_app/features/quiz/presentation/views/widgets/quiz_number_of_questions.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final List<int> numberOfQuestions = [5, 10, 25, 50];
  final List<String> levels = ['Easy', 'Medium', 'Hard'];
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
            BlocBuilder<QuizSettingsCubit, QuizSettingsState>(
              builder: (context, state) {
                return CustomButton(
                  backgroundColor:
                      state.selectedLevels.isNotEmpty &&
                              state.selectedNumber != null
                          ? AppColors.primary
                          : AppColors.onSurfaceDisabled,
                  text: "Start Quiz",
                  textColor: AppColors.surface,
                  onPressed: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
