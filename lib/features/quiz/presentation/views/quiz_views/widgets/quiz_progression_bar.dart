import 'package:flutter/material.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';

class QuizProgressionBar extends StatelessWidget {
  const QuizProgressionBar({
    super.key,
    required this.index,
    required this.length,
  });
  final int index;
  final int length;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Question ${index + 1} of $length",
          style: AppTextStyles.bodyMedium.copyWith(fontSize: 16),
        ),

        SizedBox(height: context.screenHeight * 0.015),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: (index + 1) / length,
            backgroundColor: const Color.fromARGB(255, 233, 236, 251),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: context.screenHeight * 0.015,
          ),
        ),
      ],
    );
  }
}
