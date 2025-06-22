import 'package:flutter/material.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';

class QuizWrongQuestionItem extends StatelessWidget {
  const QuizWrongQuestionItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: context.screenHeight * 0.05,
            width: context.screenWidth * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 221, 225, 234),
            ),
            child: Icon(Icons.close, color: AppColors.onSurfaceVariant),
          ),
          SizedBox(width: context.screenWidth * 0.05),
          Expanded(
            child: Text(
              "$text = ?",
              style: AppTextStyles.heading3.copyWith(fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
