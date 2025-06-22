import 'package:flutter/material.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';

class QuizLevelScoresGridItem extends StatelessWidget {
  const QuizLevelScoresGridItem({super.key, required this.level, required this.score});

  final String level;
  final double? score;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0.2),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.04,
        vertical: context.screenHeight * 0.008,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(level, style: AppTextStyles.bodyMedium),
          SizedBox(height: context.screenHeight * 0.005),
          Text(
            "${score?.toStringAsFixed(1) ?? '0'}%",
            style: AppTextStyles.heading3.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
