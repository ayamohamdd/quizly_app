import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';

class QuizNumberOfQuestions extends StatelessWidget {
  const QuizNumberOfQuestions({
    super.key,
    required this.numberOfQuestions,
    // required this.selectedNumber,
    // required this.onChanged,
  });

  final List<int> numberOfQuestions;
  // final int selectedNumber;
  // final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizSettingsCubit, QuizSettingsState>(
      builder: (context, state) {
        return Wrap(
          spacing: 10,
          children:
              numberOfQuestions.map((number) {
                final isSelected = state.selectedNumber == number;

                return ChoiceChip(
                  label: Text(
                    '$number',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      context.read<QuizSettingsCubit>().selectNumber(number);
                    }
                  },
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                );
              }).toList(),
        );
      },
    );
  }
}
