import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/core/widgets/custom_button.dart';
import 'package:quizly_app/features/skill_performance/presentation/manager/cubit/skill_performance_cubit.dart';
import 'package:quizly_app/features/skill_performance/presentation/manager/cubit/skill_performance_state.dart';

class QuizPerformanceView extends StatelessWidget {
  const QuizPerformanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add")),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.05,
          vertical: context.screenHeight * 0.02,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Performance", style: AppTextStyles.heading2),
            SizedBox(height: context.screenHeight * 0.025),
            Container(
              width: double.infinity,
              height: context.screenHeight * 0.125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.2),
              ),
              child: Padding(
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
                      "80%",
                      style: AppTextStyles.heading3.copyWith(fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
