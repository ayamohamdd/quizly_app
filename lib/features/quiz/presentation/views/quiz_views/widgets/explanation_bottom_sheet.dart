import 'package:flutter/material.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';

class ExplanationBottomSheet extends StatelessWidget {
  const ExplanationBottomSheet({super.key, this.explanation});
  final String? explanation;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.screenHeight * 0.3,
      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurfaceVariant,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.05,
          vertical: context.screenHeight * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: context.screenHeight * 0.005,
                width: context.screenWidth * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.onPrimary,
                ),
              ),
            ),
            SizedBox(height: context.screenHeight * 0.02),
            Text("Incorrect", style: AppTextStyles.heading3),
            SizedBox(height: context.screenHeight * 0.015),
            Text(
              explanation!,
              style: AppTextStyles.bodyMedium.copyWith(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
