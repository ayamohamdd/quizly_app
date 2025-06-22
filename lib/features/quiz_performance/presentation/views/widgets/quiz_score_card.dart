import 'package:flutter/material.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';

class QuizScoreCard extends StatelessWidget {
  const QuizScoreCard({super.key, required this.score});
  final double score;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.screenHeight * 0.125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0.2),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.05,
        vertical: context.screenHeight * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Total Score", style: AppTextStyles.bodyMedium),
          SizedBox(height: context.screenHeight * 0.01),
          Text(
            "${score.toStringAsFixed(1)}%",
            style: AppTextStyles.heading3.copyWith(fontSize: 22),
          ),
        ],
      ),
    );
  }
}
