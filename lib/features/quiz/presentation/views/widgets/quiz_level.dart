import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';

class QuizLevel extends StatefulWidget {
  const QuizLevel({
    super.key,
    required this.levels,
  });

  final List<String> levels;

  @override
  State<QuizLevel> createState() => _QuizLevelState();
}

class _QuizLevelState extends State<QuizLevel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizSettingsCubit, QuizSettingsState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8,
          children:
              widget.levels.map((level) {
                final isSelected = state.selectedLevels.contains(level);

                return ChoiceChip(
                  label: Text(
                    level,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color:
                          isSelected ? AppColors.surface : AppColors.onSurface,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) {
                    context.read<QuizSettingsCubit>().toggleLevel(level);
                  },

                  selectedColor: AppColors.primary,
                );
              }).toList(),
        );
      },
    );
  }
}
