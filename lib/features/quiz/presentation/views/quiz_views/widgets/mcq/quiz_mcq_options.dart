import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/features/quiz/domain/entities/mcq_options_entity.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';

class QuizMcqOptions extends StatelessWidget {
  final List<McqOptionsEntity> questionOptions;
  final int questionIndex;

  const QuizMcqOptions({
    super.key,
    required this.questionOptions,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizSettingsState>(
      builder: (context, state) {
        final selectedIndex = state.selectedMcqOptions[questionIndex];

        return Column(
          children: List.generate(questionOptions.length, (index) {
            final isSelected = selectedIndex == questionOptions[index].id;

            return GestureDetector(
              onTap: () {
                context.read<QuizCubit>().selectMcqOption(questionIndex,  questionOptions[index].id!);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: context.screenHeight * 0.015,
                ),
                margin: EdgeInsets.only(bottom: context.screenHeight * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:
                        isSelected
                            ? AppColors.primary
                            : AppColors.onSurfaceVariant,
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.screenWidth * 0.06,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppColors.primary
                                    : AppColors.onSurfaceVariant,
                            width: 2,
                          ),
                        ),
                        child:
                            isSelected
                                ? Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                                : null,
                      ),
                      SizedBox(width: context.screenWidth * 0.04),
                      Expanded(
                        child: Text(
                          " ${questionOptions[index].optionText}",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color:
                                isSelected
                                    ? AppColors.primary
                                    : AppColors.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
