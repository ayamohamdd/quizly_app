import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/features/quiz/domain/entities/mcq_options_entity.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/mcq/quiz_mcq_option_tile.dart';

class QuizMcqOptions extends StatelessWidget {
  final List<McqOptionsEntity> questionOptions;
  final int questionId;

  const QuizMcqOptions({
    super.key,
    required this.questionOptions,
    required this.questionId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizSettingsState>(
      builder: (context, state) {
        final selected = state.selectedMcqOptions[questionId];
        final isDisabled = state.disabledQuestions[questionId] ?? false;

        return SingleChildScrollView(
          child: Column(
            children:
                questionOptions.map((option) {
                  final optionText = option.optionText!;
                  final isSelected = selected == optionText;

                  return McqOptionTile(
                    optionText: optionText,
                    isSelected: isSelected,
                    isDisabled: isDisabled,
                    onTap: () {
                      if (!isDisabled) {
                        SetupSeviceLocator.sl<QuizCubit>().selectMcqOption(
                          questionId,
                          optionText,
                        );
                      }
                    },
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
