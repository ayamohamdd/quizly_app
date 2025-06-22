import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/features/quiz_performance/presentation/manager/cubit/quiz_performance_cubit.dart';
import 'package:quizly_app/features/quiz_performance/presentation/manager/cubit/quiz_performance_state.dart';

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
        child: BlocBuilder<QuizPerformanceCubit, GetQuizPerformanceState>(
          builder: (context, state) {
            return Column(
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
                          "${state.score ?? 0}%",
                          style: AppTextStyles.heading3.copyWith(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: context.screenHeight * 0.03),

                if (state.quizPerformanceList != null)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.quizPerformanceList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2.5,
                    ),
                    itemBuilder: (context, index) {
                      final score =
                          state.quizPerformanceList![index].percentage;
                      final level =
                          state.quizPerformanceList![index].questionLevel;

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
                            Text('$level', style: AppTextStyles.bodyMedium),
                            SizedBox(height: context.screenHeight * 0.005),
                            Text(
                              "${score?.toStringAsFixed(1) ?? '0'}%",
                              style: AppTextStyles.heading3.copyWith(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            );
          },
          
        ),
      ),
    );
  }
}
